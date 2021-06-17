# Ascent Technical Challenge - Ruby (Backend)

We have a take-home coding challenge that we'd like you to complete. I've
attached a test suite with an empty ruby class for you to flesh out. See below
and let me know if you have any questions.

Please Note:

1. This is an actual test suite from our app, and it's about sorting rule
numbers.
2. The regulators write the rule numbers however they please, for example
they'll write rule 2.9 and then move on to rule 2.10 and 2.11 - which makes sense to a human but if we just alpha-sort the rules they'll end up in the wrong order.
3. All the test cases in this class are actual use cases we've observed in the
wild.
4. Each test begins with a `sorted` variable that shows the intended output.
5. We reverse that array to ensure it's in an incorrect order, use our ruby
class to re-sort, and then compare against the original.

## Running things

```sh
$ bundle install
$ bundle exec rspec
```
