Through a chain effect, where somewhere in the chain was 
[Vincent Pantaloni](https://twitter.com/panlepan/status/954684356718727169), and then 
[Matt Parker](https://www.youtube.com/watch?v=4CbPksEl51Q), and eventually 
[Daniel Shiffman](https://www.youtube.com/watch?v=--6eyLO78CY&t=14s) I came to learn about Lissajouse Curves table. 

Here is a code to generate these in Matlab/Octave. Just run:
    
    LissajouseCurveTable() % a 6x6 demo
or 
    
    LissajouseCurveTable(10,1) % a 10x10 table, and it saves every frame.

The processing gets really slow very quickly. So, to have fun, you might have to save the files and then make a gif out of them, here are some examples of the gifs:
The creation:

![creation of a 6x6 table](6x6fast.gif)

On loop: (would make a good screensaver!)
![a 6x6 table on loop](6x6fast_loop.gif)

Here are some commands that I may or may not have used in creating the gifs from linux terminal:

    ls *.png > list ; seq `ls | wc -l` | paste list - | awk -F\\t '{ print $1, "IMG"$2".png"}' | xargs -n2 mv
    ffmpeg -f image2 -framerate 40 -i IMG%d.png animation.gif
