defmodule Content.Field.RichText.Node.ParagraphTest do
  use ExUnit.Case

  alias Content.Field.RichText.ValidationError
  alias Content.Field.RichText.Node
  alias Content.Field.RichText.Node.Paragraph
  alias Content.Field.RichText.Node.Text
  alias Content.Factory.RichText

  describe "Node.validate/1" do
    test "returns the paragraph when content is empty" do
      node = %Paragraph{content: []}

      assert Node.validate(node) == node
    end

    test "returns error when content is invalid" do
      node = %Paragraph{content: [%Paragraph{}, %Text{}, %Paragraph{}]}

      assert %ValidationError{node: ^node, received: [%Paragraph{}, %Paragraph{}]} =
               Node.validate(node)
    end

    test "returns the paragrph when valid" do
      node = %Paragraph{content: [%Text{}]}

      assert Node.validate(node) == node
    end
  end

  describe "Node.to_html/1" do
    test "returns the html for the node" do
      node =
        RichText.build(:document, %{
          content: [
            RichText.build(:paragraph, %{
              content: [RichText.build(:text, %{value: "Some text"})]
            })
          ]
        })

      assert Node.to_html(node) == "<p>Some text</p>"
    end

    test "integration test - gets custom atributes" do
      node =
        RichText.build(:document, %{
          content: [
            RichText.build(:paragraph, %{
              content: [
                RichText.build(:text, %{value: "Text in Blockquote"}),
                RichText.build(:blockquote, %{
                  content: [
                    RichText.build(:paragraph, %{
                      content: [RichText.build(:text, %{value: "Text in Blockquote"})]
                    })
                  ]
                })
              ]
            })
          ]
        })

      assert Node.to_html(node) ==
               "<p class=\"aClass\">Text in Blockquote<blockquote><p>Text in Blockquote</p></blockquote></p>"
    end
  end
end
