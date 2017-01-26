## Boxes

Boxes is a cli program to draw boxes around ascii text. See man boxes.

List all box styles with ```boxes -l``` There are pretty and practical styles, like code comments.


### CLI

    $ echo load balancer | boxes -d stone 
    +---------------+
    | load balancer |
    +---------------+

    $ echo -e "DMZ \n$(echo load balancer | boxes -d stone)"  |boxes -d stone
    +-------------------+
    | DMZ               |
    | +---------------+ |
    | | load balancer | |
    | +---------------+ |
    +-------------------+

### From VIM

    :r !date | boxes -d stone 
    +------------------------------+
    | Thu Jan 26 16:31:50 EST 2017 |
    +------------------------------+

Or make a shell comment:

    :r !date | boxes -d pound-cmt
    # Thu Jan 26 17:15:14 EST 2017

Add padding:

    :r !date | boxes -d pound-cmt -p t1b1
    #
    # Thu Jan 26 17:16:11 EST 2017
    #

HTML comments with padding:

    :r !date | boxes -d html-cmt -p t1b1
    <!--                              -->
    <!-- Thu Jan 26 17:19:25 EST 2017 -->
    <!--                              -->

Add new next above it:

    Date box
    +------------------------------+
    | Thu Jan 26 16:31:50 EST 2017 |
    +------------------------------+

Visually select the box and 

    :'<,'>! boxes -d stone  
    +----------------------------------+
    | Date box                         |
    | +------------------------------+ |
    | | Thu Jan 26 16:31:50 EST 2017 | |
    | +------------------------------+ |
    +----------------------------------+

To pad the bottom to match the top

    :'<,'>! boxes -d stone -p b1 

    +----------------------------------+
    | Date box                         |
    | +------------------------------+ |
    | | Thu Jan 26 16:31:50 EST 2017 | |
    | +------------------------------+ |
    |                                  |
    +----------------------------------+

Horizontally align boxes copy the lines thus and join them with 'J'.

    +------------------------------+
    +------------------------------+
    | Thu Jan 26 16:31:50 EST 2017 |
    | Thu Jan 26 16:31:50 EST 2017 |
    +------------------------------+
    +------------------------------+

Then select all and ```!boxes -d stone```

    Dates
    +------------------------------+   +------------------------------+
    | Thu Jan 26 16:31:50 EST 2017 |   | Thu Jan 26 16:31:50 EST 2017 |
    +------------------------------+   +------------------------------+

Becomes:

    +---------------------------------------------------------------------+
    | Dates                                                               |
    | +------------------------------+   +------------------------------+ |
    | | Thu Jan 26 16:31:50 EST 2017 |   | Thu Jan 26 16:31:50 EST 2017 | |
    | +------------------------------+   +------------------------------+ |
    +---------------------------------------------------------------------+

### Other links

1. [http://boxes.thomasjensen.com/]
1. [https://www.cyberciti.biz/tips/unix-linux-draw-any-kind-of-boxes-around-text-editor.html]

