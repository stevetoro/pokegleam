import decode
import tallgrass/client.{type Client}
import tallgrass/common/pokemon_type.{type PokemonType, pokemon_type}
import tallgrass/common/resource.{type Resource, resource}

pub type PokemonForm {
  PokemonForm(
    id: Int,
    name: String,
    order: Int,
    form_order: Int,
    is_default: Bool,
    is_battle_only: Bool,
    is_mega: Bool,
    form_name: String,
    pokemon: Resource,
    types: List(PokemonType),
    version_group: Resource,
  )
}

const path = "pokemon-form"

/// Creates a new Client.
/// This is a re-export of client.new, for the sake of convenience.
pub fn new() {
  client.new()
}

/// Fetches a paginated list of pokemon form resources.
///
/// # Example
///
/// ```gleam
/// let result = form.new() |> form.fetch()
/// ```
pub fn fetch(client: Client) {
  client.fetch_resources(client, path)
}

/// Fetches a pokemon form given a pokemon form resource.
///
/// # Example
///
/// ```gleam
/// let client = form.new()
/// use res <- result.try(client |> form.fetch())
/// let assert Ok(first) = res.results |> list.first
/// client |> form.fetch_resource(first)
/// ```
pub fn fetch_resource(client: Client, resource: Resource) {
  client.fetch_resource(client, resource, pokemon_form())
}

/// Fetches a pokemon form given the pokemon form ID.
///
/// # Example
///
/// ```gleam
/// let result = form.new() |> form.fetch_by_id(1)
/// ```
pub fn fetch_by_id(client: Client, id: Int) {
  client.fetch_by_id(client, path, id, pokemon_form())
}

/// Fetches a pokemon form given the pokemon form name.
///
/// # Example
///
/// ```gleam
/// let result = form.new() |> form.fetch_by_name("arceus-bug")
/// ```
pub fn fetch_by_name(client: Client, name: String) {
  client.fetch_by_name(client, path, name, pokemon_form())
}

fn pokemon_form() {
  decode.into({
    use id <- decode.parameter
    use name <- decode.parameter
    use order <- decode.parameter
    use form_order <- decode.parameter
    use is_default <- decode.parameter
    use is_battle_only <- decode.parameter
    use is_mega <- decode.parameter
    use form_name <- decode.parameter
    use pokemon <- decode.parameter
    use types <- decode.parameter
    use version_group <- decode.parameter
    PokemonForm(
      id,
      name,
      order,
      form_order,
      is_default,
      is_battle_only,
      is_mega,
      form_name,
      pokemon,
      types,
      version_group,
    )
  })
  |> decode.field("id", decode.int)
  |> decode.field("name", decode.string)
  |> decode.field("order", decode.int)
  |> decode.field("form_order", decode.int)
  |> decode.field("is_default", decode.bool)
  |> decode.field("is_battle_only", decode.bool)
  |> decode.field("is_mega", decode.bool)
  |> decode.field("form_name", decode.string)
  |> decode.field("pokemon", resource())
  |> decode.field("types", decode.list(of: pokemon_type()))
  |> decode.field("version_group", resource())
}
