defmodule Content.RichText.Parser do
  alias Content.Field.RichText.Node.Custom
  alias Content.Field.RichText.Node.Paragraph
  alias Content.Field.RichText.Node.Text
  alias Content.Field.RichText.Node.Blockquote
  alias Content.Field.RichText.Node.OrderedList
  alias Content.Field.RichText.Node.ListItem
  alias Content.Field.RichText.Node.{Heading1, Heading2, Heading3, Heading4, Heading5, Heading6}

  def search_adapter([first], rest, adapter) do
    case adapter.html_block([first]) do
      :no_match -> {default_html(first, adapter), rest}
      match -> {match, rest}
    end
  end

  def search_adapter([last | rest] = current_block, remainder, adapter) do
    case adapter.html_block(current_block) do
      :no_match -> search_adapter(rest, [last | remainder], adapter)
      match -> {match, remainder}
    end
  end

  def default_html(node, adapter)

  def default_html(%Paragraph{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"p", [], content}
  end

  def default_html(%Blockquote{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"blockquote", [], content}
  end

  def default_html(%OrderedList{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"ol", [], content}
  end

  def default_html(%ListItem{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"li", [], content}
  end

  def default_html(%Heading1{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h1", [], content}
  end

  def default_html(%Heading2{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h2", [], content}
  end

  def default_html(%Heading3{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h3", [], content}
  end

  def default_html(%Heading4{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h4", [], content}
  end

  def default_html(%Heading5{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h5", [], content}
  end

  def default_html(%Heading6{} = node, adapter) do
    content = adapter.parse_content(node.content)
    {"h6", [], content}
  end

  def default_html(%Custom{node_type: "br"}, _adapter) do
    {"br", [], []}
  end

  def default_html(%Text{marks: [%{type: "code"} | rest]} = node, adapter) do
    text = struct(node, %{marks: rest})
    {"pre", [], [{"code", [], [default_html(text, adapter)]}]}
  end

  def default_html(%Text{marks: [%{type: "bold"} | rest]} = node, adapter) do
    text = struct(node, %{marks: rest})
    {"b", [], [default_html(text, adapter)]}
  end

  def default_html(%Text{marks: [%{type: "italic"} | rest]} = node, adapter) do
    text = struct(node, %{marks: rest})
    {"em", [], [default_html(text, adapter)]}
  end

  def default_html(%Text{marks: [%{type: "underline"} | rest]} = node, adapter) do
    text = struct(node, %{marks: rest})
    {"u", [], [default_html(text, adapter)]}
  end

  def default_html(%Text{marks: [], value: value}, _), do: value
end
