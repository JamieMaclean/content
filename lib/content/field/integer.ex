defmodule Content.Field.Integer do
  defstruct [
    :name,
    id: "",
    available_options: [],
    localized: false,
    required: false,
    contentful_type: "Integer",
    ecto_type: :integer,
    omitted: false
  ]

  @type t :: %Content.Field.Integer{
          id: String.t(),
          available_options: list(String.t()),
          contentful_type: String.t(),
          name: String.t(),
          ecto_type: :integer,
          localized: boolean(),
          required: boolean(),
          omitted: boolean()
        }
end