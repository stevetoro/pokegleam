import decode
import tallgrass/client.{type Client}
import tallgrass/common/resource.{type Resource, resource}

pub type PokemonLocationArea {
  PokemonLocationArea(
    location_area: Resource,
    version_details: List(VersionDetail),
  )
}

pub type VersionDetail {
  VersionDetail(
    max_chance: Int,
    encounter_details: List(EncounterDetail),
    version: Resource,
  )
}

pub type EncounterDetail {
  EncounterDetail(
    min_level: Int,
    max_level: Int,
    chance: Int,
    method: Resource,
    condition_values: List(Resource),
  )
}

const path = "pokemon,encounters"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a pokemon location area given the pokemon ID.
///
/// # Example
///
/// ```gleam
/// let result = location_area.new() |> location_area.fetch_for_pokemon_with_id(1)
/// ```
pub fn fetch_for_pokemon_with_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, decode.list(of: pokemon_location_area()))
}

/// Fetches a pokemon location area given the pokemon name.
///
/// # Example
///
/// ```gleam
/// let result = location_area.new() |> location_area.fetch_for_pokemon_with_name("bulbasaur")
/// ```
pub fn fetch_for_pokemon_with_name(client: Client, name: String) {
  client.fetch_by_name(
    client,
    path,
    name,
    decode.list(of: pokemon_location_area()),
  )
}

fn pokemon_location_area() {
  decode.into({
    use location_area <- decode.parameter
    use version_details <- decode.parameter
    PokemonLocationArea(location_area, version_details)
  })
  |> decode.field("location_area", resource())
  |> decode.field("version_details", decode.list(of: version_detail()))
}

fn version_detail() {
  decode.into({
    use max_chance <- decode.parameter
    use encounter_details <- decode.parameter
    use version <- decode.parameter
    VersionDetail(max_chance, encounter_details, version)
  })
  |> decode.field("max_chance", decode.int)
  |> decode.field("encounter_details", decode.list(of: encounter_detail()))
  |> decode.field("version", resource())
}

fn encounter_detail() {
  decode.into({
    use min_level <- decode.parameter
    use max_level <- decode.parameter
    use chance <- decode.parameter
    use method <- decode.parameter
    use condition_values <- decode.parameter
    EncounterDetail(min_level, max_level, chance, method, condition_values)
  })
  |> decode.field("min_level", decode.int)
  |> decode.field("max_level", decode.int)
  |> decode.field("chance", decode.int)
  |> decode.field("method", resource())
  |> decode.field("condition_values", decode.list(of: resource()))
}
