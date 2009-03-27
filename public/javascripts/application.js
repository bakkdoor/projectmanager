function load_worktimes() {
    var project_id = $('project_selection').value;
    $$('div.worktimes_project_listing').invoke('hide');
    Effect.Appear("worktimes_project_" + project_id);
}
