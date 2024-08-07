( ( $, debug, region, util, widgetUtil ) => {
    "use strict";

    const barTemplate = document.createElement('template');
    barTemplate.id = 'bg-progress-bar-template';
    barTemplate.innerHTML = `
    <style>
        :host {
            --bar-width: 500px;
            --bar-height: 30px;
            --progress-border-radius: 1rem;
            --sofar: 0;
            --totalwork:100;
            --foreground-width: calc(calc(var(--sofar) * var(--bar-width)) / var(--totalwork));
            --foreground-border-top-right-radius: 0px;
            --foreground-border-bottom-right-radius: 0px;
            display: flex;
            align-items: center;
            justify-content: center;
            height: min-content;
        }

        .progress-container {
            display: flex;
            flex-direction: column;
        }

        .background-progress, .foreground-progress {
            width: var(--bar-width);
            height: var(--bar-height);
            background-color: var(--background-color);
            border-radius: var(--progress-border-radius);
        }

        .foreground-progress {
            width: var(--foreground-width);
            background-color: var(--foreground-color);
            border-top-right-radius: var(--foreground-border-top-right-radius);
            border-bottom-right-radius: var(--foreground-border-bottom-right-radius);
            transition: width 1s ease;
            align-content: center;
        }

        .progress-status {
            display: var(--progress-status-display);
            text-align: center;
            margin: .125rem;
        }

        .progress-percentage {
            color: var(--progress-percentage-color);
            font-weight: var(--progress-percentage-font-weight, 500);
            display: var(--progress-percentage-display);
            margin-left: 0.5rem;
        }
    </style>
    <div class="progress-container">
        <div class="progress-status"></div>
        <div class="background-progress">
            <div class="foreground-progress">
                <span class="progress-percentage">0%</span>
            </div>
        </div>
    </div>
    `;

    const circularTemplate = document.createElement('template');
    circularTemplate.id = 'bg-progress-circular-template';
    circularTemplate.innerHTML = `
    <style>

        :host {
            --max-width: 500px;
            --circle-size: 150px;
            --sofar: 0;
            --totalwork:100;
            --percentage: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: min-content;
        }

        .progress-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .progress-status {
            display: var(--progress-status-display);
            text-align: center;
            margin: .125rem;
            color: var(--ut-component-text-default-color);
        }

        .progress-circle {
            position: relative;
            width: var(--circle-size);
            height: var(--circle-size);
            transition: --percentage 1s ease-in-out;
        }

        .progress-circle::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: conic-gradient(var(--foreground-color) calc(var(--percentage) * 1%), var(--background-color) 0%);
            z-index: 1;
        }

        .progress-circle::after {
            content: '';
            position: absolute;
            top: 12.5%;
            left: 12.5%;
            width: 75%;
            height: 75%;
            background: var(--ut-component-background-color);
            border-radius: 50%;
            z-index: 2;
        }

        .progress-percentage {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 24px;
            font-weight: bold;
            z-index: 3;
            color: var(--ut-component-text-default-color);
            display: var(--progress-percentage-display);
        }
        
    </style>
    <div class="progress-container">
        <div class="progress-circle">
            <div class="progress-percentage">0%</div>
        </div>
        <div class="progress-status"></div>
    </div>
    `;


    class BackgroundProcessProgress extends HTMLElement {
        constructor() {
            super();

            this.shadow = this.attachShadow({ mode: "open" });
            this.progressType = this.dataset.progressType;

            let templateClone;
            if (this.progressType === "bar") {
                templateClone = barTemplate.content.cloneNode(true);
                this.style.setProperty("--bar-width", this.dataset.barWidth);
                this.style.setProperty("--bar-height", this.dataset.barHeight);
            }
            else {
                templateClone = circularTemplate.content.cloneNode(true);
                this.style.setProperty("--circle-size", this.dataset.circleSize);
            }

            // append template to the shadow DOM instead of "this"
            this.shadow.appendChild(templateClone);

            this.foregroundProgress = this.shadowRoot.querySelector('.foreground-progress');
            this.progressStatus = this.shadowRoot.querySelector('.progress-status');
            this.progressPercentage = this.shadowRoot.querySelector('.progress-percentage');
            this.progessCircle = this.shadowRoot.querySelector(".progress-circle");
            this.ajaxIdentifier = this.getAttribute( "ajax-identifier" );
            this.redirectOnCompletion = this.dataset.redirectOnCompletion;
            this.redirectLink = this.dataset.redirectLink;
            this.maxIteration = this.dataset.maxIteration;
            this.sleepTime = this.dataset.sleepTime;

            if (this.dataset.displayStatus === "N") {
                this.style.setProperty("--progress-status-display", "none");
            }

            if (this.dataset.displayPercentage === "N") {
                this.style.setProperty("--progress-percentage-display", "none");
            }

            this.style.setProperty("--background-color", '#d4d4d4');
            this.style.setProperty("--foreground-color", 'var(' + this.dataset.colorVariable + ')');
            this.style.setProperty("--progress-percentage-color", 'var(' + this.dataset.colorVariable + '-contrast)');

            region.create( this.getAttribute( "region-id" ), {
                type: "DynamicContent"
            } );
        }

        connectedCallback() {

            let element = this,
                progressType = this.progressType,
                ajaxIdentifier = this.ajaxIdentifier,
                progressStatus = this.progressStatus,
                progressPercentage = this.progressPercentage,
                progessCircle = this.progessCircle,
                redirectOnCompletion = this.redirectOnCompletion,
                redirectLink = this.redirectLink,
                maxIteration = this.maxIteration,
                sleepTime = this.sleepTime;
            
            function sleep(ms) {
                return new Promise(resolve => setTimeout(resolve, ms))
            }

            async function updateComponent(){
                let bContinue = true,
                i = 1;
                while (bContinue && i <= maxIteration) {
                    await apex.server.plugin(ajaxIdentifier).then( function( data ) {
                        if (data.sofar !== undefined){
                            element.setAttribute("aria-valuenow", data.sofar);
                            element.setAttribute("aria-valuemax", data.totalwork);
                            element.setAttribute("aria-valuetext", data.status_message !== undefined ? data.status_message : data.status);
                            element.style.setProperty('--totalwork', data.totalwork);
                            element.style.setProperty('--sofar', data.sofar);
                            if ( data.sofar === data.totalwork) {
                                element.style.setProperty('--foreground-border-top-right-radius', 'var(--progress-border-radius)');
                                element.style.setProperty('--foreground-border-bottom-right-radius', 'var(--progress-border-radius)');
                            } else {
                                element.style.setProperty('--foreground-border-top-right-radius', '0px');
                                element.style.setProperty('--foreground-border-bottom-right-radius', '0px');
                            }

                            let percentage = Math.round((data.sofar / data.totalwork)*100);
                            progressPercentage.innerHTML = isNaN(percentage) ? "0%" : percentage + "%";

                            if (progressType === "circular") {
                                progessCircle.style.setProperty("--percentage", isNaN(percentage) ? 0 : percentage );
                            }

                            progressStatus.innerHTML = data.status_message !== undefined ? data.status_message : data.status;
                            
                            bContinue = ["EXECUTING", "SCHEDULED","ENQUEUED"].includes(data.status_code);
                            if ( data.status_code === "SUCCESS" ) {
                                apex.event.trigger(element, "apex-bg-prcs-progress-exec-completed", data);
                                if ( redirectOnCompletion === "Y" ) {
                                    apex.navigation.redirect(redirectLink);
                                }
                            }
                        }
                    } );
                    i++;
                    await sleep(sleepTime);
                }
            }

            updateComponent();
        } 
    }

    $( () => {
        window.customElements.define( "apex-bg-prcs-progress", BackgroundProcessProgress );
    } );

} )( apex.jQuery, apex.debug, apex.region, apex.util, apex.widget.util );
