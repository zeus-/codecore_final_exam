module AuctionsHelper
  def state_label(state)
    case state.to_sym
    when :draft then "label label-default"
    when :published then "label label-info"
    when :reserve_met then "label label-primary"
    end
  end
end
