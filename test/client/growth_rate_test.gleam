import api/growth_rate.{type GrowthRate}
import client/growth_rate as client
import gleam/list
import gleeunit/should

pub fn fetch_by_id_test() {
  client.fetch_by_id(1) |> should.be_ok |> should_be_slow
}

pub fn fetch_by_name_test() {
  client.fetch_by_name("slow") |> should.be_ok |> should_be_slow
}

fn should_be_slow(growth_rate: GrowthRate) {
  growth_rate.id |> should.equal(1)
  growth_rate.name |> should.equal("slow")
  growth_rate.formula |> should.equal("\\frac{5x^3}{4}")

  let description = growth_rate.descriptions |> list.first |> should.be_ok
  description.description |> should.equal("lente")
  description.language.name |> should.equal("fr")
  description.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let level = growth_rate.levels |> list.first |> should.be_ok
  level.level |> should.equal(1)
  level.experience |> should.equal(0)

  let species = growth_rate.pokemon_species |> list.first |> should.be_ok
  species.name |> should.equal("growlithe")
  species.url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/58/")
}
