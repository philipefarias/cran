class PackagesUpdaterService
  SOURCE_URL = "http://cran.r-project.org/src/contrib"

  attr_reader :server, :count, :repository

  def initialize(server, count = 50, repository: Package)
    @server = server.new SOURCE_URL
    @count  = count
    @repository = repository
  end

  def call
    packages_list.each do |name_and_version|
      local_package = LocalPackage.new(*name_and_version.values, source: server.url)
      params = params_from_description local_package.description

      create_package params
    end
  end

  private

  def params_from_description(description)
    description.inject({}) do |memo, (key,value)|
      new_key   = key.gsub(/(.*\/)*(.+)/, '\2').underscore
      new_value = value

      case new_key
      when /author|maintainer/
        new_key << "s"
        new_value = value_for_people(value)
      when "package"
        new_key = "name"
      end

      if package_attributes.include?(new_key)
        memo[new_key.to_sym] = new_value
      end

      memo
    end
  end

  def value_for_people(value)
    people = value.strip.squeeze(" ").gsub(/ and /, ",").split(/ *, */)
    people.map do |person|
      m = person.match(/(.+) <(.+)>|(.+)/)
      name, email = m.values_at(1..3).compact
      { name: name, email: email }
    end
  end

  def create_package(params)
    authors     = params.delete(:authors)
    maintainers = params.delete(:maintainers)

    package = repository.new(params).tap do |object|
      authors.each     { |author|     find_or_build_person_for object.authors,     author     }
      maintainers.each { |maintainer| find_or_build_person_for object.maintainers, maintainer }
    end

    package.save
  end

  def find_or_build_person_for(association, params)
    person = people_repository.find_by_name params[:name]

    if person
      person.update(params)
      association << person
    else
      association.build params
    end
  end

  def package_attributes
    repository.column_names | ["authors", "maintainers"]
  end

  def packages_list
    @packages_list ||= server.list count
  end

  def people_repository
    Person
  end
end
