defmodule CarDataWeb.VehicleView do
  use CarDataWeb, :view

  alias CarData.Schema.Vehicle.Image
  alias CarDataWeb.VehicleView

  def render("image.json", %{results: results, total_count: total_count}) do
    %{data: render_many(results, VehicleView, "image_result.json", as: :image_result), total_count: total_count}
  end

  def render("image_result.json", %{image_result: image_result}) do
    %{
      id: image_result.id,
      width: image_result.width,
      height: image_result.height,
      vehicle_id: image_result.vehicle_id,
      image: Base.encode64(image_result.image)
    }
  end
end
