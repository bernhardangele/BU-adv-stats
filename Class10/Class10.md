Linear Mixed Models
========================================================
author: Bernhard Angele
date: Advanced Statistics
autosize: true


Linear mixed models (LMMs)
============================================================
- The final step to greatness!
    - Note that we can really only scratch the surface here.
- Main issue:
    - We know how to to regressions for continuous and discrete DVs now
    - We know what the regression equivalent of a between-subjects ANOVA is and we can take the regression analysis much further than an ANOVA or traditional ANCOVA would let us
    - However: 
        - What if we have a within-subject or repeated measures design?
        - What if there is some other underlying correlation in the data 
        - e.g. data collected from students in different classes in different schools
        - Surely the classes and schools share some variance -- how to account for that?
                    
Moving from linear regression to linear mixed models
=============================================================
- In repeated-measures ANOVA, we've dealt with within-subjects effects by removing the variance due to subject differences from the error
    - Essentially, we have added a "subject" factor to the model
    - Linear mixed models enable us to do the same thing for all kinds of regression analyses

Problem: how to add subject as a factor
=============================================================
- We could simply add a "subject" factor to the predictors
    - This would reflect the systematic differences between subjects
        - But that's not quite right: how do we deal with a factor with 40 levels?
        - Also, we want to generalise our model to more than those 40 subjects that are in the analysis
        - How do we do that?
    - Subject is really like a random variable: we get a different set each time we run the experiment
    - Instead of analysing the subject effect in a generalisable way, we really just want to get rid of the subject variance in the most efficient way possible

Problem: how to add subject as a factor (2)
=============================================================
- Fixed effects vs. random effects
    - Fixed effects: repeatable, generalisable (e.g. experiment condition)
    - Random effects: non-repeatable, sampled from a general population
    - Mixed effects models include both fixed and random effects
- Another issue with including subject as a fixed effect:
    - Each subject would take up a degree of freedom
    - That would majorly impact the power of our analysis
    - LMMs solve this issue by a procedure called **shrinkage**
    
Shrinkage
===============================================================
- Conceptually, LMMs allow subjects to have individual effects (e.g. in an eye-tracking experiment subject 1 might have an intercept of 200 ms, while subject 2 might have an intercept of 210 ms), but they pull each subject's effects
towards an underlying distribution of subject effects
- This reflects the idea that if 20 other subjects have intercepts between 180 and 220 ms, the current subject is unlikely to have an intercept of 400 ms, even though it looks like that from the data
- Shrinkage also helps majorly with missing data issues (although it won't fix them for you!)
- The downside of shrinkage is that it isn't clear what the $df_{Error}$ should be
    - This leads to some issues later on.
    
Example
==============================================================
A PhD student wants to investigate whether our mood affects how we react to visual scenes. In order to do this, she showed 40 subjects a total of 40 scenes. There are two version of each scene: one contains people, the other one doesn't -- everything else is identical. The PhD student spent a considerable amount of time taking photos to ensure this (until her supervisor got a bit impatient). Before the experiment, all subjects were asked to rate their current mood on a scale from 0 (very sad) to 100 (very happy). They then looked at each scene and rated how much they liked it on a scale from 0 (hate it) to 20 (love it). The student's hypothesis is that if you are happy, you should want to see scenes with people. If you are unhappy, you should prefer scenes without people. The data are given below. Will the student find what she is looking for? Or will she have to start from scratch and be in even more trouble with her supervisor?

Example Data
==============================================================
- Subject: Subject ID (1-40)
- Item: Item ID (1-40)
- Scene Type: within-item factor ("no people" vs. "people")
- Mood: between-subject factor (scale from 0--100)
- Rating: Dependent variable (scale from 0 to 20)
- For these kinds of data, R has a massive advantage over SPSS in terms of usability.
  - But you can still get the same results in SPSS!
- Don't be scared, I'll be walking you through this with R first and then show you how to do it in SPSS.























































```
Error in file(file, "rt") : cannot open the connection
```
