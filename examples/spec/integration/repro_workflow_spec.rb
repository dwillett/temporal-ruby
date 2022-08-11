require 'workflows/repro_workflow'

describe ReproWorkflow do

  it 'finishes the workflow' do
    workflow_id = SecureRandom.uuid
    run_id = Temporal.start_workflow(
      ReproWorkflow,
      options: { workflow_id: workflow_id }
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
