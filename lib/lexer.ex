defmodule Lexer do
  defstruct [:input, :ch, position: 0, read_position: 1, result: []]

  def new(input) do
    ch = Enum.at(input, 0)
    %Lexer{input: input, ch: [ch]}
  end

  def read_token(lexer) do
    case create_if_const_token_type(lexer.ch) do
      {:ok, new_token} ->
          lexer
          |> Map.update!(:result, fn result -> result ++ [new_token] end)
          |> update_lexer()

      {:error, :identifier} ->
          literal = read_identifier(lexer)
          literal_length = String.length(literal)
          case Token.get_keyword_token_type_if_exist(literal) do
            {:ok, keyword_token_type} ->
              new_token = Token.new(keyword_token_type, literal)
              lexer
              |> Map.update!(:result, fn result -> result ++ [new_token] end)
              |> update_lexer(literal_length)
            {:error, _} ->
              new_token = Token.new(Token.token_type.ident, literal)
              lexer
              |> Map.update!(:result, fn result -> result ++ [new_token] end)
              |> update_lexer(literal_length)
          end
      {:error, :illegal} ->
          new_token = Token.new(Token.token_type.illegal, lexer.ch)
          lexer
          |> Map.update!(:result, fn result -> result ++ [new_token] end)
          |> update_lexer()
    end
  end

  #"="や";"など、定型のtoken_typeに一致すればTokenを生成して返す
  defp create_if_const_token_type(ch) do
    case ch do
      '=' -> {:ok, Token.new(Token.token_type.assign,    to_string(ch))}
      ';' -> {:ok, Token.new(Token.token_type.semicolon, to_string(ch))}
      '(' -> {:ok, Token.new(Token.token_type.lparen,    to_string(ch))}
      ')' -> {:ok, Token.new(Token.token_type.rparen,    to_string(ch))}
      ',' -> {:ok, Token.new(Token.token_type.comma,     to_string(ch))}
      '+' -> {:ok, Token.new(Token.token_type.plus,      to_string(ch))}
      '{' -> {:ok, Token.new(Token.token_type.lbrace,    to_string(ch))}
      '}' -> {:ok, Token.new(Token.token_type.rbrace,    to_string(ch))}
      nil -> {:ok, Token.new(Token.token_type.eof,       "")}
      ch  ->
        if is_letter?(ch) do
          {:error, :identifier}
        else
          {:error, :illegal}
        end
    end
  end


  defp is_letter?(ch) do
    (('a'< ch) and (ch < 'z')) or (('A'< ch) and (ch < 'Z')) or (ch == '_')
  end

  defp read_identifier(lexer) do
    hoge =
    lexer.input
    |> Enum.drop(lexer.position)
    IO.inspect(hoge)
    hoge
    |> Enum.take_while(&(is_letter?(&1)))
    |> to_string()
  end

  #指定の回数lexerを進める
  defp update_lexer(lexer, count \\ 1) do
    updated_lexer =
      if lexer.read_position >= String.length(to_string(lexer.input)) do
        lexer
        |> Map.update!(:ch, fn _ch -> nil end)
      else
        lexer
        |> Map.update!(:ch, fn _l -> [Enum.at(lexer.input, lexer.read_position)]  end)
        |> Map.update!(:position, &(&1 + 1))
        |> Map.update!(:read_position, &(&1 + 1))
      end

    case count do
      1 -> updated_lexer
      c -> update_lexer(updated_lexer, c-1)
    end
  end

end
