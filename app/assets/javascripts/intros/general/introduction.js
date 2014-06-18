var intro = introJs();
intro.setOptions({


steps: [
    {
        element: '#step-brand',
        intro: "Welcome to Model United Nations. <br><br> This introduction will give you a short overview of how things go around here.",
        position: 'bottom'
    },
    {
        element: '#step-side-navigation-conferences',
        intro: "Here you can see all conferences you manage or attend.",
        position: 'right'
    },
    {
        element: '#step-side-navigation-delegations',
        intro: "And these are all your delegations.",
        position: 'right'
    },
    {
        element: '#step-side-navigation-groups',
        intro: 'Those are the groups you register with at conferences.',
        position: 'right'
    },
    {
        element: '#step-side-navigation-resolutions',
        intro: "And here you can work on all your resolutions as well as position papers.",
        position: 'right'
    },
    {
        element: '#step-navigation-messages',
        intro: 'Up here you can connect with people.',
        position: 'left'
    },
    {
        element: '#step-navigation-tasks',
        intro: 'These are the tasks you should complete.',
        position: 'left'
    },
    {
        element: '#step-navigation-notifications',
        intro: 'Those notifications will keep you up to date.',
        position: 'left'
    },
    {
        element: '#step-navigation-user',
        intro: 'And here you can manage yourself.',
        position: 'left'
    },
]
});

/*
 .onchange(function(targetElement) {
 console.log(targetElement.id);
 switch (targetElement.id)
 {
 case "step1":
 function1();
 break;
 case "step2":
 function2();
 break;
 }
 */