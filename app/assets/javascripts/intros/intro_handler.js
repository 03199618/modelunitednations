if(gon.intro)
{
    $('#tutorial_modal').modal('show');
}

function tutorial(season, episode){
    delegate_tutorial.start()
}

function startIntro(){
    var intro = introJs();
    intro.setOptions({
        steps: [
            {
                intro: "Hello world!"
            },
            {
                element: document.querySelector('#step-brand'),
                intro: "This is a tooltip."
            },
        ]
    });

    intro.start();
}