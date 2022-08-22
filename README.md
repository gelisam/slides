# Slides

Here are the slides for my presentation. As you might have noticed if you saw it live, my slide format is a bit unusual: each slide is a text file, usually with some code in it. This is because I use [git-slides](https://github.com/gelisam/git-slides#readme), a tool I wrote which makes it easy for me to create presentations with lots of code demonstrations in them. Unfortunately, this format makes it harder for you to browse the slides, because it's not a standard format like a pdf file.

The way the format works is that each slide corresponds to a git commit, so if you look at `src/Main.hs`, you will see the last slide. If you have a git tool which makes it easy to go backwards and forwards in the history, you can use that to look at all the slides. If not, you can try [git-slides](https://github.com/gelisam/git-slides#readme); it's a command-line tool, so you would type `git-slides prev` to go the the previous slide and `git-slides next` to go to the next slide. It also has some vim bindings which call those when you press backspace and space, respectively, and it should be trivial to implement similar bindings for other editors.
