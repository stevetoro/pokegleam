import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/location/region.{type Region}

pub fn fetch_test() {
  let resource =
    region.new()
    |> region.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  region.new()
  |> region.fetch_resource(resource)
  |> should.be_ok
  |> should_be_kanto
}

pub fn fetch_by_id_test() {
  region.new()
  |> region.fetch_by_id(1)
  |> should.be_ok
  |> should_be_kanto
}

pub fn fetch_by_name_test() {
  region.new()
  |> region.fetch_by_name("kanto")
  |> should.be_ok
  |> should_be_kanto
}

fn should_be_kanto(region: Region) {
  region.id |> should.equal(1)
  region.name |> should.equal("kanto")

  let assert NamedResource(url, name) =
    region.locations |> list.first |> should.be_ok
  name |> should.equal("celadon-city")
  url |> should.equal("https://pokeapi.co/api/v2/location/67/")

  let assert NamedResource(url, name) = region.main_generation
  name |> should.equal("generation-i")
  url |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let name = region.names |> should_have_english_name
  name.name |> should.equal("Kanto")

  let assert NamedResource(url, name) =
    region.pokedexes |> list.first |> should.be_ok
  name |> should.equal("kanto")
  url |> should.equal("https://pokeapi.co/api/v2/pokedex/2/")

  let assert NamedResource(url, name) =
    region.version_groups |> list.first |> should.be_ok
  name |> should.equal("red-blue")
  url |> should.equal("https://pokeapi.co/api/v2/version-group/1/")
}
