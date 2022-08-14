require 'workflows/repro_workflow'

describe ReproWorkflow do

  it 'finishes the workflow' do
    workflow_id = SecureRandom.uuid
    run_id = Temporal.start_workflow(
      ReproWorkflow,
      # I'm having issues with the latest docker-compose not being able to terminate workflows easily
      options: { workflow_id: workflow_id, timeouts: { run: 60 } }
    )

    Temporal.signal_workflow(ReproWorkflow, 'finish', workflow_id, run_id)

    Temporal.await_workflow_result(
      ReproWorkflow,
      workflow_id: workflow_id,
      run_id: run_id,
    )

    # Will fail awaiting result if it doesn't finish
    expect(true).to be true
  end
end
