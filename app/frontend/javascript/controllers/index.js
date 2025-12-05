import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

import { application } from "./application.js";

eagerLoadControllersFrom("controllers", application);
