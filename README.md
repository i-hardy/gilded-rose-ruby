# Gilded Rose Kata - Ruby

Using the [Ruby translation](https://github.com/emilybache/GildedRose-Refactoring-Kata) of the kata provided by Emily Bache.

I approached the kata initially by creating tests to cover all the functionality in the spec and provided by the original update_quality method, then extracting out the various different conditions of the update_quality method into separate methods within the GildedRose class, so that I could see more clearly where the responsibilities lay.

Unable to do anything to the existing Item class, despite how terrible it is, I decided to treat it as a kind of initial interface, which would be used to generate instances of separate classes for the different kinds of items which required different update conditions.

Once the classes were created and had the necessary functionality I introduced the creation of 'classified items' into the GildedRose class, which could then be acted upon, and their properties transferred back to the Item instances in the original items list.

At this point I could finally implement the new "Conjured" items feature!

### How to use
To run the tests:
```
$ git clone
$ cd gilded-rose-ruby
$ rspec
~~~
Note that there is a considerable amount of test duplication- I have retained all the original tests I wrote for the update_quality method, in order to demonstrate that the original functionality has been preserved.
