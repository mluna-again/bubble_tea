defmodule BubbleTeaWeb.Redirect do
  use BubbleTeaWeb, :controller

  def init(opts), do: opts

  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
    |> halt()
  end
end
