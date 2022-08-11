class ReproWorkflow < Temporal::Workflow
  attr_reader :state

  def execute
    workflow.on_signal("finish") do
      # When this sleep is invoked in the signal handler,
      # the workflow execution does not complete
      workflow.sleep(1)
      @state = "finished"
    end

    @state = "started"
    workflow.wait_until do
      state == "finished"
    end

    {}
  end
end
