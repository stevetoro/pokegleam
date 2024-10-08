import decode
import tallgrass/client.{type Client}
import tallgrass/common/name.{type Name, name}
import tallgrass/common/resource.{type Resource, resource}

pub type EncounterCondition {
  EncounterCondition(
    id: Int,
    name: String,
    values: List(Resource),
    names: List(Name),
  )
}

const path = "encounter-condition"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of encounter condition resources.
///
/// # Example
///
/// ```gleam
/// let result = condition |> method.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches an encounter condition given an encounter condition resource.
///
/// # Example
///
/// ```gleam
/// let client = condition.new()
/// use res <- result.try(client |> condition.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> condition.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, encounter_condition())
}

/// Fetches an encounter condition given the encounter condition ID.
///
/// # Example
///
/// ```gleam
/// let result = condition.new() |> condition.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, encounter_condition())
}

/// Fetches an encounter condition given the encounter condition name.
///
/// # Example
///
/// ```gleam
/// let result = condition.new() |> condition.fetch_by_name("swarm")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, encounter_condition())
}

fn encounter_condition() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use values <- decode.parameter
    use names <- decode.parameter
    EncounterCondition(id, name, values, names)
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("values", decode.list(of: resource()))
  |> decode.field("names", decode.list(of: name()))
}
