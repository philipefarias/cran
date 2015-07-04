# cran

This will be a really simple web interface to better search R packages in CRAN servers.

## Instructions to run
First make sure all the dependencies are installed. This are the main ones:

- Ruby 2.2.2
- Bundler

Then install the rest using bundler:

    $ bundle

After that, make sure all the tests are passing:

    $ rake

Start the web server:

    $ bundle exec rails s

And finally open it in the browser:

    $ open http://localhost:3000

## Design notes

### Spike
Again I started with a simple script to discover more about the problem.
It's just a scrap, as soon as I gain confidence the real development will start.

After downloading the packages and extracting the description with the script I started the development of the app.

### The app
I used Rails this time.
In this case, prototype something in a short amount of time, is one of the main use cases of Rails. So, I brought the cavalry.
But I didn't use it much. Most of the logic of the app are in `lib/` and `app/services/`. I find that this way the code is easier to test and to handle, in general.

Talking about the app structure, the code that interact with remote server is in `lib/`. There's two main classes there, one to get list of packages and another to get a package, store it as a Tempfile and return its description.
To coordinate everything there's a service in `app/services/`. It will get the list, iterate through it, get the packages and save its info in the database.
For the task that will run every day at 12pm there's a job in `app/jobs/` that use the service.
Finally, I created two models to save the relevant info about the packages, Package and Person. The last one will keep info about authors and maintainers.

Throughout the development there was a LOT of things that I've done but wasn't satisfied. The problem was the time (I admit that I'm not that fast).
First, a lot of the classes are doing too much. If this would continue I think breaking this classes in smaller more focused and better tested objects is the next move.
Than I would probably restructure the models. For this case, using a table for the authors and maintainers doens't seem right. There's not enough info about a person to differentiate from another.
After that I would spend some time making things faster. There's a great oportunity to deal with some things concurrently here. Fetching and extracting packages, for example.
And finally, if this should be better than the current repositories, the general design and usability must change (not really change, because there's almost none, just something must be done in this area).

Anyhow, so long, and thanks for all the fish!


\* My mind isn't really working right now... my english vocabulary is at 10%. So, sorry for that. ;)


# Here's to the future!

                                                   ,:
                                                 ,' |
                                                /   :
                                             --'   /
                                             \/ />/
                                             / <//_\
                                          __/   /
                                          )'-. /
                                          ./  :\
                                           /.' '
                                         '/'
                                         +
                                        '
                                      `.
                                  .-"-
                                 (    |
                              . .-'  '.
                             ( (.   )8:
                         .'    / (_  )
                          _. :(.   )8P  `
                      .  (  `-' (  `.   .
                       .  :  (   .a8a)
                      /_`( "a `a. )"'
                  (  (/  .  ' )=='
                 (   (    )  .8"   +
                   (`'8a.( _(   (
                ..-. `8P    ) `  )  +
              -'   (      -ab:  )
            '    _  `    (8P"Ya
          _(    (    )b  -`.  ) +
         ( 8)  ( _.aP" _a   \( \   *
       +  )/    (8P   (88    )  )
          (a:f   "     `"       `

