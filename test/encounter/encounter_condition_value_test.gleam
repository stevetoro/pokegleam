import gleam/list
import gleeunit/should
import helpers.{should_have_english_name}
import tallgrass/common/resource.{NamedResource}
import tallgrass/encounter/condition/value.{type EncounterConditionValue}

pub fn fetch_test() {
  let resource =
    value.new()
    |> value.fetch
    |> should.be_ok
    |> fn(response) { response.results |> list.first |> should.be_ok }

  value.new()
  |> value.fetch_resource(resource)
  |> should.be_ok
  should_be_swarm_yes
}

pub fn fetch_by_id_test() {
  value.new()
  |> value.fetch_by_id(1)
  |> should.be_ok
  |> should_be_swarm_yes
}

pub fn fetch_by_name_test() {
  value.new()
  |> value.fetch_by_name("swarm-yes")
  |> should.be_ok
  |> should_be_swarm_yes
}

fn should_be_swarm_yes(encounter_condition_value: EncounterConditionValue) {
  encounter_condition_value.id |> should.equal(1)
  encounter_condition_value.name |> should.equal("swarm-yes")

  let assert NamedResource(url, name) = encounter_condition_value.condition
  name |> should.equal("swarm")
  url |> should.equal("https://pokeapi.co/api/v2/encounter-condition/1/")

  let name = encounter_condition_value.names |> should_have_english_name
  name.name |> should.equal("During a swarm")
}
