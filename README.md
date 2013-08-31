Simple Games Keeper
=================

Hi there! Welcome to my simple games collection - Simple Games Keeper. This project is something I did for fun and to learn. Using the Giantbomb API, users can add/remove games to and from their collection in a simple and clean manner. Although the project is simple, the app covers many key elements of iOS/mobile development - delegates, Core Data, lazy loading, background threading, etc.

Here's a list of some key features that I'm proud of:
1. When a user queries a popular term (such as "Mario"), I ensure that the tablerow results are lazy loaded as the user navigates down the table. I do this by quering an extra 25 results when the user is 2/3rds down the page. As a result, there is an almost seamless transition when querying large results.

2. I thought that the carousel for the home screen turned out really well. By adding a small reflection with custom assets I created, I feel that it looked really good against a simple, minimalistic white backdrop. 

3. Implementing core data was quite the challenge as it takes some time getting used to. In the end, I was able to learn how to add,remove and fetch results with this app.

Stuff to work on in later versions:
1. As of this moment, there is no filtering among consoles. Hopefully, Giantbomb can update their API to accomodate this. However some solutions that I thought of was modifying the JSON or perhaps when I parse it I can pick and choose what goes into my games array.

2. Image caching for the table view would be nice. Right now, all I have is text in each cell. It would be nice if it would also display an image on the left-hand side of each cell.  

3. I would like to add more functionality when a user is viewing a specific game. Perhaps embedding a video or adding a similar games section would improve the experience.

Special Thanks:
iCarousel, ReflectionView, my co-workers at Xtreme Labs (It was awesome to work with you guys this summer).
