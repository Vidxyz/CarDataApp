defmodule CarDataWeb.VehicleController do
  use CarDataWeb, :controller

  alias CarData.Repo

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show_image(conn, params = %{"vehicle_id" => vehicle_id}) do
    with {:ok, results} <- Repo.Vehicle.find_vehicle_image(vehicle_id) do
      render(conn, "image.json", %{results: results, total_count: length(results)})
    end
  end
end
