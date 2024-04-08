const mdtApp = new Vue({
    el: "#container",
    data: {
        page: "Home",
        officer: {
            name: "Guest",
            department: "police",
			rank: ''
        },
        style: {
            police: true
        },

        offenses: [],
        modal: null,
        notify: null,

        homepage: {
            button_press: 0,
            reports: false,
            warrants: false
        },
        recent_searches: {
            person: [],
        },

        report_search: "",
        report_edit: {
            enable: false,
            data: {}
        },
        report_results: {
            query: "",
            results: false
        },
        report_selected: {
            id: null,
            date: null,
            name: null,
            title: null,
            incident: null,
            charges: null,
            author: null,
            jailtime: null
        },
        report_new: {
            title: "",
            charges: {},
            charges_search: "",
            incident: "",
            name: null,
            char_id: null,
            focus: "name",
            recommended_fine: 0,
            recommended_sentence: 0,
        },

        offender_search: "",
        offender_results: {
            query: "",
            results: false
        },
        offender_selected: {
            firstname: null,
            lastname: null,
            notes: "",
            convictions: null,
            mugshot_url: "",
            id: null,
            identifier: null,
            haswarrant: false,
        },
        offender_changes: {
            notes: "",
            mugshot_url: "",
            convictions: [],
            convictions_removed: [],
            bail: false
        },

        warrants: [],
        warrant_search: "",
        warrant_results: {
            query: "",
            results: {}
        },
        warrant_selected: {
            name: null,
            id: null,
            char_id: null,
            report_id: null,
            report_title: null,
            report_charges: {},
            date: null,
            expire: null,
            notes: null
        },
        warrant_new: {
            name: null,
            char_id: null,
            report_id: null,
            report_title: null,
            report_search: "",
            charges: {},
            notes: null
        }
    },
    methods: {
        changePage(page) {
            this.page = page;
            ClearActiveNavItems();
            if (page == "Home") {
                $("#home").addClass("nav-active");
            } else if (page == "Search Reports") {
                $("#search-reports").addClass("nav-active");
            } else if (page == "Search Offenders") {
                $("#search-offenders").addClass("nav-active");
            } else if (page == "Warrants") {
                $.post('http://mdt/getWarrants');
                $("#warrants").addClass("nav-active");
            } else if (page == "Submit Report") {
                $("#submit-report").addClass("nav-active");
            }
        },
        closeMDT() {
            $.post('http://mdt/close', JSON.stringify({}));
        },
        getClass(element) {
            if (this.style.police) {
                return element
            } 
        },
        OffenderSearch() {
            if (this.offender_search) {

                this.offender_results.query = this.offender_search;
                $.post('http://mdt/performOffenderSearch', JSON.stringify({
                    query: this.offender_search
                }));

                this.offender_results.results = false;
                return;
            }
        },
        OpenOffenderDetails(id) {
            for (var key in this.offender_results.results) {
                if (id == this.offender_results.results[key].id) {

                    $.post('http://mdt/viewOffender', JSON.stringify({
                        offender: this.offender_results.results[key]
                    }));

                    this.modal = 'loading';
                    return;
                }
            }
        },
        SaveOffenderChanges() {
            $.post('http://mdt/saveOffenderChanges', JSON.stringify({
                changes: this.offender_changes,
                id: this.offender_selected.charidentifier,
                identifier: this.offender_selected.identifier
            }));
            this.modal = null;
            this.offender_selected.notes = this.offender_changes.notes;
            this.offender_selected.mugshot_url = this.offender_changes.mugshot_url;
            this.offender_selected.convictions = this.offender_changes.convictions;
            this.offender_selected.bail = this.offender_changes.bail;
            return;
        },
        ReportSearch() {
            if (this.report_search) {

                this.report_results.query = this.report_search
                this.warrant_new.report_search = this.report_search
                $.post('http://mdt/performReportSearch', JSON.stringify({
                    query: this.report_search
                }));

                this.report_results.results = false;
                this.report_selected = {
                    id: null,
                    date: null,
                    name: null,
                    title: null,
                    report: null,
                    charges: null,
                    author: null
                };
                return;
            }
        },
        AddCharge(id) {
            for (var key in this.offenses) {
                if (id == this.offenses[key].id) {
                    var offense_name = this.offenses[key].label
                    if (this.report_new.charges[offense_name]) {
                        Vue.set(this.report_new.charges, offense_name, this.report_new.charges[offense_name] + 1);
                    } else {
                        Vue.set(this.report_new.charges, offense_name, 1);
                    }

                    this.report_new.recommended_fine = this.report_new.recommended_fine + this.offenses[key].amount
                    this.report_new.recommended_sentence = this.report_new.recommended_sentence + this.offenses[key].jailtime

                    return;
                }
            }

        },
        RemoveCharge(offense) {
            for (var key in this.report_new.charges) {
                if (offense == key) {
                    if ((this.report_new.charges[offense] - 1) > 0) {
                        Vue.set(this.report_new.charges, offense, this.report_new.charges[offense] - 1)
                    } else {
                        Vue.delete(this.report_new.charges, offense)
                    }

                    for (var key in this.offenses) {
                        if (offense == this.offenses[key].label) {
                            this.report_new.recommended_fine = this.report_new.recommended_fine - this.offenses[key].amount
                            this.report_new.recommended_sentence = this.report_new.recommended_sentence - this.offenses[key].jailtime
                        }
                    }

                    return;
                }
            }
        },
        SubmitNewReport() {
            if (this.report_new.title && this.report_new.char_id && this.report_new.incident) {
                $.post('http://mdt/submitNewReport', JSON.stringify({
                    title: this.report_new.title,
                    char_id: this.report_new.char_id,
                    name: this.report_new.name,
                    charges: this.report_new.charges,
                    incident: this.report_new.incident,
                }));

                this.report_new.title = "";
                this.report_new.charges = {};
                this.report_new.charges_search = "";
                this.report_new.incident = "";
                this.report_new.name = null;
                this.report_new.char_id = null;
                this.report_new.focus = "name";
                this.report_new.recommended_fine = 0;
                this.report_new.recommended_sentence = 0;
                this.offender_search = "";
                this.offender_results.query = "";
                this.offender_results.results = false;
                this.changePage("Search Reports");
                return;   
            }
        },
        OpenOffenderDetailsById(charidentifier) {
            $.post('http://mdt/getOffender', JSON.stringify({
                char_id: charidentifier
            }));

            this.modal = 'loading';
            return;
        },
        ToggleReportEdit() {
            if (this.report_edit.enable) {
                this.report_edit.enable = false;
                this.report_edit.data = {}
            } else {
                this.report_edit.enable = true;
                this.report_edit.data.title = this.report_selected.title;
                this.report_edit.data.incident = this.report_selected.incident;
            }
            return;
        },
        DeleteSelectedReport() {
            $.post('http://mdt/deleteReport', JSON.stringify({
                id: this.report_selected.id,
            }));
            this.changePage("Search Reports");
            this.report_selected = {
                id: null,
                date: null,
                name: null,
                title: null,
                report: null,
                charges: null,
                author: null
            };
            this.report_results = {
                query: "",
                results: false
            };
            this.report_search = "";
            return;
        },
        SaveReportEditChanges() {
            $.post('http://mdt/saveReportChanges', JSON.stringify({
                id: this.report_selected.id,
                title: this.report_edit.data.title,
                incident: this.report_edit.data.incident
            }));

            this.report_selected.title = this.report_edit.data.title;
            this.report_selected.incident = this.report_edit.data.incident;
            this.ToggleReportEdit();
            return;
        },
        WarrantReportSearch() {
            if (this.warrant_new.report_search) {

                this.report_results.query = this.report_search
                $.post('http://mdt/performReportSearch', JSON.stringify({
                    query: this.report_search
                }));

                this.report_results.results = false;
                this.report_selected = {
                    id: null,
                    date: null,
                    name: null,
                    title: null,
                    report: null,
                    charges: null,
                    author: null
                };
                return;
            }
        },
        SubmitNewWarrant() {
            var date = new Date();
            date.setDate(date.getDate() + 7);
            $.post('http://mdt/submitNewWarrant', JSON.stringify({
                name: this.warrant_new.name,
                char_id: this.warrant_new.char_id,
                report_id: this.warrant_new.report_id,
                report_title: this.warrant_new.report_title,
                charges: this.warrant_new.charges,
                notes: this.warrant_new.notes,
                expire: date
            }));
            this.warrant_new = {
                name: null,
                char_id: null,
                report_id: null,
                report_title: null,
                report_search: "",
                charges: {},
                notes: null
            }
            this.report_results.results = false;
            this.report_results.query = "";
            return;
        },
        DeleteSelectedWarrant() {
            $.post('http://mdt/deleteWarrant', JSON.stringify({
                id: this.warrant_selected.id,
            }));
            this.warrant_selected = {
                name: null,
                id: null,
                char_id: null,
                report_id: null,
                report_title: null,
                report_charges: {},
                date: null,
                expire: null,
                notes: null
            };
            return;
        },
        OpenReportById(id) {
            $.post('http://mdt/getReport', JSON.stringify({
                id: id
            }));
            this.modal = 'loading';
            return;
        },
        RemoveConviction(conviction) {
            for (var offense in this.offender_changes.convictions) {
                if (offense == conviction) {
                    if ((this.offender_changes.convictions[offense] - 1) > 0) {
                        Vue.set(this.offender_changes.convictions, offense, this.offender_changes.convictions[offense] - 1)
                    } else {
                        Vue.delete(this.offender_changes.convictions, offense)
                        this.offender_changes.convictions_removed.push(offense)
                    }
                }
            }
        },
        showNotification(message) {
            this.notify = message;
            $('#notification').show('fast', 'swing');
            setTimeout(function(){
                $('#notification').hide('fast', 'swing');
            }, 2500);
            return;
        },
    },
    computed: {
        filtered_offenses() {
            return this.offenses.filter(offense => {
                if (
                    offense.label.toLowerCase().search(this.report_new.charges_search.toLowerCase()) != -1
                    )
                    return offense;
            })
        },
        filtered_warrants() {
            return this.warrants.filter(warrant => {
                if (
                    warrant.name.toLowerCase().search(this.warrant_search.toLowerCase()) != -1
                    )
                    return warrant;
            })
        }
    }
});

$("#home").addClass("nav-active");

document.onreadystatechange = () => {
    if (document.readyState === "complete") {
        window.addEventListener('message', function(event) {
            if (event.data.type == "enable") {
                document.body.style.display = event.data.isVisible ? "block" : "none";
            } else if (event.data.type == "returnedPersonMatches") {
                mdtApp.offender_results.results = event.data.matches;
            } else if (event.data.type == "returnedOffenderDetails") {
                mdtApp.offender_selected = event.data.details;
                mdtApp.offender_results.results = false;
                mdtApp.offender_results.query = "";
                mdtApp.offender_changes.notes = mdtApp.offender_selected.notes;
                mdtApp.offender_changes.mugshot_url = mdtApp.offender_selected.mugshot_url;
                mdtApp.offender_changes.convictions = mdtApp.offender_selected.convictions;
                mdtApp.offender_changes.convictions_removed = [];
                mdtApp.offender_changes.bail = mdtApp.offender_selected.bail;
                mdtApp.offender_search = mdtApp.offender_selected.firstname + " " + mdtApp.offender_selected.lastname;
                mdtApp.changePage("Search Offenders");

                mdtApp.recent_searches.person.unshift(event.data.details);
                if (mdtApp.recent_searches.person.length > 3) {
                    Vue.delete(mdtApp.recent_searches.person, 3)
                }

                mdtApp.modal = null;
            } else if (event.data.type == "offensesAndOfficerLoaded") {
                mdtApp.offenses = event.data.offenses;
                mdtApp.officer.name = event.data.name;
            } else if (event.data.type == "returnedReportMatches") {
                mdtApp.report_results.results = event.data.matches;
            } else if (event.data.type == "returnedWarrants") {
                mdtApp.warrants = event.data.warrants;
            } else if (event.data.type == "completedWarrantAction") {
                mdtApp.changePage("Warrants");
            } else if (event.data.type == "returnedReportDetails") {
                mdtApp.changePage("Search Reports");
                mdtApp.report_selected = event.data.details;

                mdtApp.modal = null;
            } else if (event.data.type == "recentReportsAndWarrantsLoaded") {
                mdtApp.homepage.reports = event.data.reports;
                mdtApp.homepage.warrants = event.data.warrants;
                mdtApp.officer.name = event.data.officer;
				mdtApp.officer.rank = event.data.rank + ' ';
                if (mdtApp.officer.department != event.data.department) {
                    mdtApp.officer.department = event.data.department;
                    if (event.data.department == 'police') {
                        mdtApp.style.police = true;
                    }
                }
            } else if (event.data.type == "sendNotification") {
                mdtApp.showNotification(event.data.message);
            } else if (event.data.type == "closeModal") {
                mdtApp.modal = null;
            };
        });
    };
};

document.onkeydown = function (data) {
    if (data.which == 27 || data.which == 112) { // ESC or F1
        $.post('http://mdt/close', JSON.stringify({}));
    } else if (data.which == 13) { // enter
        /* stop enter key from crashing MDT in an input?  */
        var textarea = document.getElementsByTagName('textarea');
        if (!$(textarea).is(':focus')) {
            return false;
        }
    }
};

function ClearActiveNavItems() {
    $("#home").removeClass("nav-active");
    $("#search-reports").removeClass("nav-active");
    $("#search-offenders").removeClass("nav-active");
    $("#warrants").removeClass("nav-active");
    $("#submit-report").removeClass("nav-active");
}

function WarrantTimer() {
    var timer = setInterval(function() {
        for (var key in mdtApp.warrants) {
            var warrant = mdtApp.warrants[key]
            var now = new Date().getTime();
            var expire_time = new Date(warrant.expire).getTime();
            var t = expire_time - now;
            if (t >= 0) {
                var days = Math.floor(t / (1000 * 60 * 60 * 24));
                var hours = Math.floor((t % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var mins = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60));
                var secs = Math.floor((t % (1000 * 60)) / 1000);
                warrant.expire_time = days + 'd ' + hours + 'h ' + mins + 'm ' + secs + 's';
            } else {
                warrant.expire_time = 'EXPIRED';
                $.post('http://mdt/deleteWarrant', JSON.stringify({
                    id: warrant.id
                }));
                Vue.delete(mdtApp.warrants, key)
            }
        }
    }, 1000);
}

WarrantTimer()
