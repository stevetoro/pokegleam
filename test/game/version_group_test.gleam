import gleam/list
import gleeunit/should
import tallgrass/common/resource.{NamedResource}
import tallgrass/game/version_group.{type VersionGroup}

pub fn fetch_test() {
  let resource =
    version_group.new()
    |> version_group.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  version_group.new()
  |> version_group.fetch_resource(resource)
  |> should.be_ok
  |> should_be_red_blue
}

pub fn fetch_by_id_test() {
  version_group.new()
  |> version_group.fetch_by_id(1)
  |> should.be_ok
  |> should_be_red_blue
}

pub fn fetch_by_name_test() {
  version_group.new()
  |> version_group.fetch_by_name("red-blue")
  |> should.be_ok
  |> should_be_red_blue
}

fn should_be_red_blue(version_group: VersionGroup) {
  version_group.id |> should.equal(1)
  version_group.name |> should.equal("red-blue")
  version_group.order |> should.equal(1)

  let assert NamedResource(url, name) = version_group.generation
  name |> should.equal("generation-i")
  url |> should.equal("https://pokeapi.co/api/v2/generation/1/")

  let assert NamedResource(url, name) =
    version_group.move_learn_methods |> list.first |> should.be_ok
  name |> should.equal("level-up")
  url |> should.equal("https://pokeapi.co/api/v2/move-learn-method/1/")

  let assert NamedResource(url, name) =
    version_group.pokedexes |> list.first |> should.be_ok
  name |> should.equal("kanto")
  url |> should.equal("https://pokeapi.co/api/v2/pokedex/2/")

  let assert NamedResource(url, name) =
    version_group.regions |> list.first |> should.be_ok
  name |> should.equal("kanto")
  url |> should.equal("https://pokeapi.co/api/v2/region/1/")

  let assert NamedResource(url, name) =
    version_group.versions |> list.first |> should.be_ok
  name |> should.equal("red")
  url |> should.equal("https://pokeapi.co/api/v2/version/1/")
}
