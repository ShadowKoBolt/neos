# README

## Requirements

* ruby 2.4.2
* sqlite3

## Install depedencies

Use `bundle` command

## Database creation

To create and seed database run `rails db:setup`

## Run server

Run `rails s` and visit [http://localhost:3000]()

## How to run the test suite

Run `rspec`

## Notes

* Use sqlite for portability and ease of installation and setup versus other
  common alternatives (such as postgresql and mysql) and don't need to use more
complex features at this time.
* Use [reform](https://github.com/trailblazer/reform) to avoid complex
  state-dependent business logic from creeping into models (see
Basket::CheckoutForm).
* Use decorators to keep view logic out of models.
* Use service objects to keep logic out of controllers when it starts to grow
  complex.
* Don't make any attempt to handle or store credit card - this would be better
  handled by another service.

# TODOs

* Add missing specs and increase coverage
* Track more information on the order object (such as the total price paid on
  checkout)
* Add overcommit (or alternative) for precommit hooks
* Enforce test coverage %
