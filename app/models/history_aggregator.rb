class HistoryAggregator
  attr_reader :project, :history_items

  def initialize(project)
    @project = project
  end

  def history(order: nil)
    return history_items if order.nil? || order == :asc || order == 'asc'
    return reverse_chronological_order if order == :desc || order == 'desc'
  end

  private

  def history_items
    @history_items ||= (tracking_status + comments).sort_by {|item| item[:created_at] }
  end

  def reverse_chronological_order
    history_items.reverse
  end

  def comments
    project.comments.pluck(:detail, :created_at).map {|result| { event: result[0], created_at: result[1], source: :comment } }
  end

  def tracking_status
    TrackingStatusHistory
      .where(project_id: project.id)
      .pluck(:tracking_status, :history_started_at)
      .map {|result| { event: result[0].titleize, created_at: result[1], source: :tracking_status } }
  end
end
