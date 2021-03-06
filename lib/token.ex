defmodule Token do
  defstruct [:type, :literal]

  def new(type, literal), do: %Token{type: type, literal: literal}
  def token_type() do
    %{
      illegal: "illegal",
      eof: "eof",

      #識別子 + リテラル
      ident: "ident",
      int: "int",

      #演算子
      assign: "=",
      plus: "+",
      minus: "-",
      bang: "!",
      asterisk: "*",
      slash: "/",

      lt: "<",
      gt: ">",

      eq: "==",
      not_eq: "!=",

      #デリミタ
      comma: ",",
      semicolon: ";",

      lparen: "(",
      rparen: ")",
      lbrace: "{",
      rbrace: "}",

      #キーワード
      function: "function",
      let:      "let",
      true:     "true",
      false:    "false",
      if:       "if",
      else:     "else",
      return:   "return",
    }
  end

  def keywords() do
    %{
      "fn"     => "function",
      "let"    => "let",
      "true"   => "true",
      "false"  => "false",
      "if"     => "if",
      "else"   => "else",
      "return" => "return",
    }
  end

  def get_keyword_token_type_if_exist(literal) do
    keywords = keywords()
    keyword = Enum.filter(keywords, fn {key, _value} -> key == literal end)
    if keyword != [] do
      {_, keyword_token_type} = Enum.at(keyword, 0)
      {:ok, keyword_token_type}
    else
      {:error, :not_found}
    end
  end
end
