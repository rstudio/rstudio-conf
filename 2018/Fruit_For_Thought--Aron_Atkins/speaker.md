# Fruit for Thought

<div class="slide">
## Title Slide

Hello. Thanks for coming. My name is Aron Atkins and I am part of the team
building RStudio Connect.
</div>


<div class="slide">
## RStudio Connect Logo

I grew up as part of a farming family with apples always nearby.
</div>


<div class="slide">
## Howard Atkins

This is my grandfather in one of our orchards.

When I was young, I traveled with my father throughout New York and New
England to visit other apple farms. We saw acres and acres of trees.

Some of the names you know: McIntosh. Delicious. Empire. Some you may not:
Gravenstein; Winesap; and an apple named for its size: the massive Twenty
Ounce.
</div>


<div class="slide">
## Macoun

My favorite has always been the Macoun. A slight purplish hue with the right
amount of tart. You find Macouns only at the close of fall; my favorite time
of the year in New England.
</div>


<div class="slide">
## Tiled Watercolors

I searched for a way to combine farming, apples and `rmarkdown`. Obviously.

I found the U.S. Department of Agriculture Pomological Watercolor Collection
and fell in love. There are over seven thousand paintings, lithographs, and
line drawings with almost four thousand images of apples.
</div>


<div class="slide">
## Building the report
    
I was able to find a dataset someone built by screen-scraping the USDA site.
    
I started building an R Markdown report to extract images of Macouns from the
watercolor collection.
    
Here is my first attempt using that dataset to build a report.
</div>
    

<div class="slide">
### `image.Rmd`
    
It's pretty bare. Just an image and the name of the fruit.
    
The code slurps in the JSON dataset, filters for entries that are Macoun
apples, chooses one, and emits its image.
</div>


<div class="slide">
### `macoun.Rmd`
    
That's a nice start, but let's try to compare the details of the selected art
against the entire collection.
    
Here's an improved version of the report that compares the type of fruit and
its variety to the other works. The metadata for the chosen image and how it
compares to the collection is being used to generate the report text.

The first graph plots the contributions over time by this artist. The second
graph shows when artwork with the same type of fruit and variety were created.

This is probably similar to reports that you are already writing - mixing
computation, text, and visualizations.
</div>
    

<div class="slide">
### Introducing Parameters
    
When I was working on this report, I realized early on that there are only two
paintings of Macouns in the watercolor collection.

If I want to try reporting on other fruits and varieties, I could edit this R
Markdown file in-place (edit the report to look for bartlett pears). I could
also edit a copy of the source file.
    
I don't love these answers. It's really easy to accidentally end up with subtly
different behavior in each of the source files or forget the different
experiments that were tried.
    
Parameterized reports let you vary your inputs without changing your source.
</div>

    
<div class="slide">
### `simple.Rmd`
    
Let's take this report and allow the customization of three variables: the
type of fruit, the variety, and the date range.

In this version, we have added a "params" block to the YAML report
configuration. The report variables have just been hoisted up as parameters.

Here is where we are using the parameters in our report. I am using simple
variable assignment so all three parameters are used together, but these
parameter references could appear anywhere in the report.
    
We can still "knit" this report as before. The rendering uses the values in
our parameter section.
</div>
    
    
<div class="slide">
### Knitting
    
The IDE "Knit" menu has a "Knit with Parameters" option, and that's where we
can start to see the power of parameterized reports.
    
This dialog is generated based on the configurable parameters. We'll worry
about year later, but let's change these values. Our "apples" report just let
us analyze the "grapes" in the collection!
</div>
    
    
<div class="slide">
### `parameterized.Rmd`
    
Let's improve parameter customization a bit.
    
First, let's change the "fruit" parameter to use a selector. I've extracted
the ten most common types of fruit and have them listed as options. The "any"
choice is being used as a wild card.
    
"Variety" still allows string input. Its default is the empty string,
indicating no filtering by variety. The title change helps us remember that
blank input is OK.
    
Year is customized as a two-value slider.
</div>
    

<div class="slide">
### Improved knitting
    
Let's see how these improvements change the customization panel.

(try fruit: grapes, variety: black, year: include 1917)
    
This parameterized report now acts as a template that can generate a whole
class of documents.
</div>
    

<div class="slide">
### Deploying
    
We can deploy this code to RStudio Connect. As you can see, the content is the
same as I was able to produce within the RStudio IDE, but this one was
rendered on the server.
    
We can create a new variation of this report with different parameter values.
These are the same controls that we saw in the IDE. Let's create a variant for
"grapes".
    
This output lives alongside the default document output. They each have their
own name. You can see that I have already created a number of variants: one
for Macouns (of course), one for strawberries, and one with a narrowed date
range to try and see if works created during the Great Depression are somehow
different.
</div>
    

<div class="slide">
### Configuring in RSC
    
Each variation of a report can be regenerated on a schedule and optionally
sent via email. The "strawberries" version of the report is being regenerated
and emailed once a day. 
    
Each report also retains the history of its previous renderings. I can look at
the strawberry report from yesterday and see what is different from today's
result. Each output of the source report tracks its own history.
</div>
    
    
<div class="slide">
## Any report can become parameterized

It is usually easy to add parameters to an existing R Markdown report. Just
hoist any constant from your code to the "params" YAML, and iterate from
there.
</div>


<div class="slide">
## Rendering from code

If you render from other R code, you can customize parameters there, as well.
</div>


<div class="slide">
## Resources

Here are some of the resources I have mentioned.

The R Markdown site contains documentation about parameterized reports and
lots of other examples.

The "Old Fruit Pictures" Twitter account posts a watercolor from the
collection every few hours.

Thank you for your time.
</div>
