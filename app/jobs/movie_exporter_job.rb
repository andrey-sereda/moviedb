class MovieExporterJob < ApplicationJob
  queue_as :default

  def perform(user)
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(user, file_path)
  end
end