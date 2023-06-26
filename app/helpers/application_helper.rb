module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts.unshift "Homey").join(" - ")
      end
    end
  end

  def tracking_status_options
    # not sure if better to use the black or white colour emoji to represent draft '⚫' or '⚪'
    tracking_statuses = Project.tracking_statuses.symbolize_keys
    tracking_status_colours = %Q(⚪🔵🟢🔵🔵🟢🟠🔴🟢)
    tracking_status_options = []
    tracking_statuses.each_with_index do |status, idx|
      tracking_status_options << [[tracking_status_colours[idx], status[1].titleize].join(" "), status[0]]
    end
    tracking_status_options
  end

  def comment_and_tracking_status_history(project)
    history_aggregator = HistoryAggregator.new(project)
    history_aggregator.history(order: :desc)
  end
end
