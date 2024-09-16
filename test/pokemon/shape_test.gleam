import gleam/list
import gleeunit/should
import tallgrass/pokemon/shape.{type PokemonShape}

pub fn fetch_by_id_test() {
  shape.fetch_by_id(1) |> should.be_ok |> should_be_ball
}

pub fn fetch_by_name_test() {
  shape.fetch_by_name("ball") |> should.be_ok |> should_be_ball
}

fn should_be_ball(shape: PokemonShape) {
  shape.id |> should.equal(1)
  shape.name |> should.equal("ball")

  let name = shape.names |> list.first |> should.be_ok
  name.name |> should.equal("Balle")
  name.language.name |> should.equal("fr")
  name.language.url |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let awesome_name = shape.awesome_names |> list.first |> should.be_ok
  awesome_name.name |> should.equal("Pomacé")
  awesome_name.language.name |> should.equal("fr")
  awesome_name.language.url
  |> should.equal("https://pokeapi.co/api/v2/language/5/")

  let species = shape.pokemon_species |> list.first |> should.be_ok
  species.name |> should.equal("shellder")
  species.url |> should.equal("https://pokeapi.co/api/v2/pokemon-species/90/")
}
