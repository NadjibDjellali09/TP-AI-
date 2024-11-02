%qst1
% ndifiniw dynamic predicat so we can change it apres
:- dynamic task/4.
% Task representation: task(TaskID, Description, Assignee, Completed).

%qst2
% ninitialisiw task with new parameters, 
create_task(TaskID, Description, Assignee) :-
    \+ task(TaskID, _, _, _), % nconfermiw bli id ta3 task raho unique by checking idha yexisti men qbl and returning false if it does
    assertz(task(TaskID, Description, Assignee, false)),
    format('Task created: ~w.~n', [TaskID]).

%qst3
% n7awso 3la task without caring about its user than assigning that user into that task
assign_task(TaskID, User) :-
    retract(task(TaskID, Description, _, Completed)),
    assertz(task(TaskID, Description, User, Completed)),
    format('Task ~w assigned to user: ~w.~n', [TaskID, User]).

%qst4
% Mark a task as completed
mark_completed(TaskID) :-
    retract(task(TaskID, Description, Assignee, _)),
    assertz(task(TaskID, Description, Assignee, true)),
    format('Task ~w marked as completed.~n', [TaskID]).

%qst5
% Display all tasks with details
display_tasks :-
    findall(TaskID, task(TaskID, _, _, _), TaskIDs),
    display_tasks_detail(TaskIDs).

%qst6

display_tasks_detail([]).
display_tasks_detail([TaskID | Rest]) :-
    task(TaskID, Description, Assignee, Completed),
    format('Task ~w:~n', [TaskID]),
    format('- Description: ~w~n', [Description]),
    format('- Assignee: ~w~n', [Assignee]),
    format('- Completion status: ~w~n', [Completed]),
    display_tasks_detail(Rest).

% Display tasks assigned to a specific user
display_tasks_assigned_to(User) :-
    findall(TaskID, task(TaskID, _, User, _), TaskIDs),
    format('Tasks assigned to ~w:~n', [User]),
    display_tasks_detail(TaskIDs).

% Display all completed tasks
display_completed_tasks :-
    findall(TaskID, task(TaskID, _, _, true), TaskIDs),
    format('Completed tasks:~n'),
    display_tasks_detail(TaskIDs).

test_tasks :-
    create_task(1, 'Implement login functionality', 'Alice'),
    create_task(2, 'Design homepage layout', 'Bob'),
    assign_task(1, 'John'),
    assign_task(2, 'Alice'),
    mark_completed(2),
    display_tasks,
    display_tasks_assigned_to('Alice'),
    display_completed_tasks.