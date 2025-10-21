const assessmentQuestions = [
  // Java Questions (1-15)
  { 
    difficulty: "Medium", 
    question: "What will be the output of the following Java code?\nclass Test {\npublic static void main(String[] args) {\nint x = 10;\nx = x++ * 2 + ++x;\nSystem.out.println(x);\n}\n}", 
    choices: ["21", "22", "32", "31"], 
    answer: "32" 
  },
  { 
    difficulty: "Easy", 
    question: "What happens if you execute the following Java code?\nclass Test {\npublic static void main(String[] args) {\ntry {\nSystem.out.println(10 / 0);\n} catch (Exception e) {\nSystem.out.println(\"Exception caught\");\n} finally {\nSystem.out.println(\"Finally block executed\");\n}\n}\n}", 
    choices: ["Compilation Error", "Exception caught", "Exception caught and Finally block executed", "Runtime Exception: ArithmeticException"], 
    answer: "Exception caught and Finally block executed" 
  },
  { 
    difficulty: "Medium", 
    question: "Which of the following statements about Java memory management is true?", 
    choices: ["Java does not use garbage collection.", "System.gc() guarantees immediate garbage collection.", "Objects without references are eligible for garbage collection.", "The finalize() method is always called before an object is garbage collected."], 
    answer: "Objects without references are eligible for garbage collection." 
  },
  { 
    difficulty: "Medium", 
    question: "What will be the output of this Java program?\npublic class Test {\npublic static void main(String[] args) {\nString s1 = new String(\"Java\");\nString s2 = \"Java\";\nString s3 = new String(\"Java\");\nSystem.out.println(s1 == s2);\nSystem.out.println(s1.equals(s2));\nSystem.out.println(s1 == s3);\n}\n}", 
    choices: ["true false false", "false true false", "false true true", "true true false"], 
    answer: "false true false" 
  },
  { 
    difficulty: "Medium", 
    question: "Which of these is true about Java interfaces?", 
    choices: ["An interface can contain instance variables.", "An interface can have static and default methods from Java 8 onward.", "An interface can extend multiple classes.", "An interface must have at least one method."], 
    answer: "An interface can have static and default methods from Java 8 onward." 
  },
  { 
    difficulty: "Hard", 
    question: "What is the result of this Java code?\npublic class Test {\npublic static void main(String[] args) {\nint[] arr = {1, 2, 3, 4, 5};\nfor (int i = 0; i < arr.length; i++) {\narr[i] = arr[arr.length - i - 1];\n}\nSystem.out.println(arr[0]);\n}\n}", 
    choices: ["5", "4", "NullPointerException", "ArrayIndexOutOfBoundsException"], 
    answer: "5" 
  },
  { 
    difficulty: "Easy", 
    question: "What will happen when running the following Java program?\npublic class Test {\npublic static void main(String[] args) {\nString s1 = \"Java\";\ns1.concat(\" Programming\");\nSystem.out.println(s1);\n}\n}", 
    choices: ["Java Programming", "Java", "Compilation Error", "NullPointerException"], 
    answer: "Java" 
  },
  { 
    difficulty: "Medium", 
    question: "Which of the following Java features allows multiple threads to access shared resources safely?", 
    choices: ["Polymorphism", "Encapsulation", "Synchronization", "Serialization"], 
    answer: "Synchronization" 
  },
  { 
    difficulty: "Hard", 
    question: "What will happen in this Java code?\nclass Parent {\nstatic void display() {\nSystem.out.println(\"Parent\");\n}\n}\nclass Child extends Parent {\nstatic void display() {\nSystem.out.println(\"Child\");\n}\n}\npublic class Test {\npublic static void main(String[] args) {\nParent obj = new Child();\nobj.display();\n}\n}", 
    choices: ["Parent", "Child", "Compilation Error", "Runtime Error"], 
    answer: "Parent" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the output of this code?\npublic class Test {\npublic static void main(String[] args) {\nint x = 5;\nSystem.out.println(x++ + ++x);\n}\n}", 
    choices: ["10", "11", "12", "13"], 
    answer: "12" 
  },
  { 
    difficulty: "Medium", 
    question: "What will be the output of this Java code?\nclass Test {\npublic static void main(String[] args) {\nSystem.out.println(1 + 2 + \"Hello\" + 3 + 4);\n}\n}", 
    choices: ["3Hello7", "3Hello34", "Hello10", "10Hello"], 
    answer: "3Hello34" 
  },
  { 
    difficulty: "Easy", 
    question: "How does Java achieve platform independence?", 
    choices: ["JVM", "JRE", "JDK", "Bytecode"], 
    answer: "Bytecode" 
  },
  { 
    difficulty: "Easy", 
    question: "What happens if you run the following code?\nclass Test {\npublic static void main(String[] args) {\nString s = null;\nSystem.out.println(s.length());\n}\n}", 
    choices: ["Compilation Error", "0", "NullPointerException", "Runtime Error"], 
    answer: "NullPointerException" 
  },
  { 
    difficulty: "Medium", 
    question: "Which of the following is NOT true about final keyword?", 
    choices: ["A final class can be inherited.", "A final method cannot be overridden.", "A final variable cannot be modified.", "A final class cannot be extended."], 
    answer: "A final class can be inherited." 
  },
  { 
    difficulty: "Easy", 
    question: "What is the output of the following Java code?\npublic class Test {\npublic static void main(String[] args) {\nint a = 10, b = 0;\ntry {\nSystem.out.println(a / b);\n} catch (ArithmeticException e) {\nSystem.out.println(\"Error\");\n} finally {\nSystem.out.println(\"Done\");\n}\n}\n}", 
    choices: ["Error Done", "Compilation Error", "0 Done", "Runtime Exception"], 
    answer: "Error Done" 
  },

  // JavaScript Questions (16-30)
  { 
    difficulty: "Medium", 
    question: "What will be the output of the following JavaScript code?\nlet a = 10;\nlet b = a++;\nconsole.log(a, b);", 
    choices: ["10 10", "11 10", "11 11", "10 11"], 
    answer: "11 10" 
  },
  { 
    difficulty: "Hard", 
    question: "What is the output?\nconsole.log(1 < 2 < 3);\nconsole.log(3 > 2 > 1);", 
    choices: ["true true", "true false", "false true", "false false"], 
    answer: "true false" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the output?\nconsole.log(+\"10\" + 5);", 
    choices: ["\"105\"", "15", "\"10\"", "NaN"], 
    answer: "15" 
  },
  { 
    difficulty: "Medium", 
    question: "What will this code log?\nconsole.log(typeof NaN);\nconsole.log(NaN === NaN);", 
    choices: ["\"number\" true", "\"number\" false", "\"NaN\" false", "\"undefined\" true"], 
    answer: "\"number\" false" 
  },
  { 
    difficulty: "Hard", 
    question: "What is the output?\nconsole.log([] == 0);\nconsole.log([] == false);", 
    choices: ["true true", "true false", "false true", "false false"], 
    answer: "true true" 
  },
  { 
    difficulty: "Medium", 
    question: "Generate Fibonacci Sequence up to N Terms\nfunction fibonacci(n) {\n// Your code here\n}\nconsole.log(fibonacci(5));", 
    choices: ["[0, 1, 1, 2, 3]", "[1, 1, 2, 3, 5]", "[1, 2, 3, 4, 5]", "[0, 1, 2, 3, 5]"], 
    answer: "[0, 1, 1, 2, 3]" 
  },
  { 
    difficulty: "Medium", 
    question: "What will be the output of the following code?\nconsole.log(1 + \"1\" - 1);", 
    choices: ["\"11\"", "1", "10", "NaN"], 
    answer: "10" 
  },
  { 
    difficulty: "Hard", 
    question: "What will this print?\nconsole.log([] + []);\nconsole.log([] + {});\nconsole.log({} + []);\nconsole.log({} + {});", 
    choices: ["\"[]\", \"[object Object]\", \"[object Object]\", \"[object Object][object Object]\"", "\"\", \"[object Object]\", \"[object Object]\", NaN", "\"[]\", \"[object Object]\", 0, NaN", "\"\", \"[object Object]\", \"[object Object]\", \"[object Object][object Object]\""], 
    answer: "\"\", \"[object Object]\", \"[object Object]\", \"[object Object][object Object]\"" 
  },
  { 
    difficulty: "Easy", 
    question: "Which method returns the last element of an array?", 
    choices: ["slice(-1)", "push()", "last()", "pop()"], 
    answer: "pop()" 
  },
  { 
    difficulty: "Easy", 
    question: "What will this code print?\nconsole.log(typeof null);", 
    choices: ["\"null\"", "\"undefined\"", "\"object\"", "\"function\""], 
    answer: "\"object\"" 
  },
  { 
    difficulty: "Hard", 
    question: "What will this code output?\nlet count = 0;\n(function immediate() {\nif (count === 0) {\nlet count = 1;\nconsole.log(count);\n}\nconsole.log(count);\n})();", 
    choices: ["1 1", "1 0", "0 1", "1 undefined"], 
    answer: "1 0" 
  },
  { 
    difficulty: "Medium", 
    question: "What will be the output?\nconsole.log(true + true);", 
    choices: ["true true", "true false", "11", "2"], 
    answer: "2" 
  },
  { 
    difficulty: "Easy", 
    question: "How do you create an array in JavaScript?", 
    choices: ["var arr = [];", "var arr = {};", "var arr = ();", "var arr = <>;"], 
    answer: "var arr = [];" 
  },
  { 
    difficulty: "Easy", 
    question: "How do you create an object literal in JavaScript?", 
    choices: ["var obj = {};", "var obj = [];", "var obj = ();", "var obj = <>;"], 
    answer: "var obj = {};" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the result of \"5\" - 3 in JavaScript?", 
    choices: ["2", "\"2\"", "NaN", "\"53\""], 
    answer: "2" 
  },

  // HTML Questions (31-37)
  { 
    difficulty: "Medium", 
    question: "What will happen if an <iframe> has the sandbox attribute?", 
    choices: ["The embedded content will run with restricted permissions.", "The iframe will load faster.", "The iframe will not display images.", "The iframe will crash."], 
    answer: "The embedded content will run with restricted permissions." 
  },
  { 
    difficulty: "Easy", 
    question: "What is the purpose of the <wbr> tag?", 
    choices: ["Forces a line break.", "Specifies a preferred line break opportunity.", "Wraps text in bold.", "Creates a space between words."], 
    answer: "Specifies a preferred line break opportunity." 
  },
  { 
    difficulty: "Medium", 
    question: "Which HTML5 API is used for offline web applications?", 
    choices: ["Web Storage API", "IndexedDB API", "AppCache API (Deprecated)", "All of the above"], 
    answer: "All of the above" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the purpose of the aria-hidden=\"true\" attribute?", 
    choices: ["Hides content from screen readers.", "Hides content from search engines.", "Hides content visually only.", "Makes content visible only when hovered."], 
    answer: "Hides content from screen readers." 
  },
  { 
    difficulty: "Medium", 
    question: "What happens if you use the <picture> element in HTML?", 
    choices: ["It provides multiple sources for an image to improve responsiveness.", "It allows adding a caption to an image.", "It embeds an external video.", "It loads an image without the need for an <img> tag."], 
    answer: "It provides multiple sources for an image to improve responsiveness." 
  },
  { 
    difficulty: "Medium", 
    question: "What does the rel=\"noopener noreferrer\" attribute in <a> tag do?", 
    choices: ["Prevents opening links in new tabs.", "Prevents the new page from accessing window.opener for security reasons.", "Prevents the browser from caching the linked page.", "Forces the browser to preload the linked page."], 
    answer: "Prevents the new page from accessing window.opener for security reasons." 
  },
  { 
    difficulty: "Easy", 
    question: "Which of the following input types was introduced in HTML5?", 
    choices: ["type=\"date\"", "type=\"password\"", "type=\"radio\"", "type=\"hidden\""], 
    answer: "type=\"date\"" 
  },

  // CSS Questions (38-45)
  { 
    difficulty: "Easy", 
    question: "Which CSS pseudo-class selects an element when it gains focus?", 
    choices: [":hover", ":active", ":focus", ":checked"], 
    answer: ":focus" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the difference between em and rem in CSS?", 
    choices: ["em is relative to the document’s root font size, while rem is relative to the parent element", "em is relative to the parent element’s font size, while rem is relative to the root element’s font size", "em and rem are both relative to the viewport width", "There is no difference"], 
    answer: "em is relative to the parent element’s font size, while rem is relative to the root element’s font size" 
  },
  { 
    difficulty: "Medium", 
    question: "Which CSS property prevents an element from being resized by the user?", 
    choices: ["resize: none;", "resize: hidden;", "resize: block;", "visibility: hidden;"], 
    answer: "resize: none;" 
  },
  { 
    difficulty: "Easy", 
    question: "How do you create a CSS variable?", 
    choices: ["let --color = red;", "var(--color: red);", "--color: red;", "color-variable: red;"], 
    answer: "--color: red;" 
  },
  { 
    difficulty: "Medium", 
    question: "Which CSS property makes an element disappear but still take up space?", 
    choices: ["visibility: hidden;", "display: none;", "opacity: 0;", "z-index: -1;"], 
    answer: "visibility: hidden;" 
  },
  { 
    difficulty: "Medium", 
    question: "What does clip-path: circle(50%); do?", 
    choices: ["Clips the element into a circular shape", "Clips the element to half of its original size", "Adds a circular shadow", "Adds a border-radius of 50%"], 
    answer: "Clips the element into a circular shape" 
  },
  { 
    difficulty: "Medium", 
    question: "What does flex-grow: 1; do in a flex container?", 
    choices: ["Shrinks the item when space is limited", "Prevents the item from growing", "Allows the item to expand and fill available space", "Centers the item"], 
    answer: "Allows the item to expand and fill available space" 
  },
  { 
    difficulty: "Medium", 
    question: "What happens when you use position: sticky; in CSS?", 
    choices: ["The element stays in place like fixed", "The element moves as the user scrolls but sticks when it reaches a certain position", "The element becomes unclickable", "It behaves the same as absolute"], 
    answer: "The element moves as the user scrolls but sticks when it reaches a certain position" 
  },

  // SQL Questions (46-50)
  { 
    difficulty: "Easy", 
    question: "What is the purpose of the SQL COALESCE() function?", 
    choices: ["Returns the first non-null value from a list.", "Combines multiple queries into one.", "Checks constraints on a column.", "Joins two tables together."], 
    answer: "Returns the first non-null value from a list." 
  },
  { 
    difficulty: "Medium", 
    question: "What is the difference between UNION and UNION ALL?", 
    choices: ["UNION removes duplicates, UNION ALL keeps them.", "UNION keeps duplicates, UNION ALL removes them.", "UNION works only with SELECT DISTINCT.", "They function the same way."], 
    answer: "UNION removes duplicates, UNION ALL keeps them." 
  },
  { 
    difficulty: "Medium", 
    question: "What will be the output of this query?\nSELECT '5' + 5;", 
    choices: ["10", "'55'", "5", "Error"], 
    answer: "10" 
  },
  { 
    difficulty: "Medium", 
    question: "What is the difference between RANK() and DENSE_RANK()?", 
    choices: ["RANK() skips ranking numbers when ties occur, DENSE_RANK() does not.", "DENSE_RANK() skips numbers, RANK() does not.", "They are the same.", "DENSE_RANK() cannot be used with ORDER BY."], 
    answer: "RANK() skips ranking numbers when ties occur, DENSE_RANK() does not." 
  },
  { 
    difficulty: "Easy", 
    question: "What is the use of NVL() function in SQL?", 
    choices: ["Returns the number of NULL values in a table.", "Replaces NULL values with a specified value.", "Checks the integrity of the table.", "Joins two tables."], 
    answer: "Replaces NULL values with a specified value." 
  }
];



// Function to randomly select questions (now shuffling the fixed 50 questions)
function getRandomQuestions(questions, count) {
    const shuffled = [...questions];
    for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }
    return shuffled.slice(0, count);
}

// Select 50 random questions from the fixed set of 50
let selectedQuestions = getRandomQuestions(assessmentQuestions, 50);
let assessmentQuestionsForExam = selectedQuestions;

const maxQuestions = 50;
let questionIndex = 0;
let userAnswers = {};
let remainingTime = 60 * 60; // 60 minutes
let warningCount = 0;
const maxWarnings = 3;
let isSubmitting = false;
let refreshAttempted = false;
let lastSwitchTime = 0;
let timeWarningShown = false;
let examCompleted = false; // Flag to track if exam is finished

function launchAssessment() {
    // Ensure fullscreen mode on load
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().catch(err => {
            console.error("Fullscreen request failed:", err);
        });
    }

    // Prevent exiting fullscreen mode during the exam
    document.addEventListener("fullscreenchange", () => {
        if (!document.fullscreenElement && !examCompleted) {
            showEscWarning("You cannot exit fullscreen mode until the exam is over!");
            document.documentElement.requestFullscreen(); // Re-enter fullscreen
        }
    });

    // Detect Esc key press for warning (optional, for extra feedback)
    document.addEventListener("keydown", (e) => {
        if (e.key === "Escape" && !examCompleted) {
            showEscWarning("You cannot exit fullscreen mode until the exam is over!");
        }
        if (e.key === "F5" || (e.ctrlKey && e.key === "r") || (e.metaKey && e.key === "r")) {
            e.preventDefault();
            refreshAttempted = true;
            showRefreshPopup();
        }
    });

    // Handle visibility change and focus loss
    document.addEventListener("visibilitychange", handleSwitch);
    window.addEventListener("blur", handleSwitch);

    // Prevent context menu (right-click)
    document.addEventListener('contextmenu', (event) => {
        event.preventDefault();
        showAlert('Right-click is disabled during the assessment.', null, hideAlert);
    });

    // Handle page unload/refresh
    window.addEventListener('beforeunload', (event) => {
        if (isSubmitting || examCompleted) return;
        if (!refreshAttempted) {
            refreshAttempted = true;
            submitAssessmentForRefresh();
        }
        event.preventDefault();
        event.returnValue = 'Are you sure you want to leave? Your exam will be submitted.';
        return 'Are you sure you want to leave? Your exam will be submitted.';
    });

    showQuestion();
    updateProgressBar();
    runTimer();
    setupEndButton();
}

function showEscWarning(message) {
    const warningDiv = document.createElement("div");
    warningDiv.id = "esc-warning";
    warningDiv.textContent = message;
    warningDiv.style.position = "fixed";
    warningDiv.style.top = "20px";
    warningDiv.style.left = "50%";
    warningDiv.style.transform = "translateX(-50%)";
    warningDiv.style.backgroundColor = "red";
    warningDiv.style.color = "white";
    warningDiv.style.padding = "10px 20px";
    warningDiv.style.borderRadius = "5px";
    warningDiv.style.zIndex = "1000";
    warningDiv.style.boxShadow = "0 2px 10px rgba(0, 0, 0, 0.2)";
    document.body.appendChild(warningDiv);

    setTimeout(() => {
        if (warningDiv.parentNode) document.body.removeChild(warningDiv);
    }, 3000);
}

function showRefreshPopup() {
    showAlert(
        'The exam will be submitted if you refresh the page. Submit now?',
        submitAssessmentForRefresh,
        () => {
            refreshAttempted = false;
            hideAlert();
        }
    );
}

function showQuestion() {
    const q = assessmentQuestionsForExam[questionIndex];
    document.getElementById("question-header").textContent = `Question ${questionIndex + 1}`;
    document.getElementById("question-body").textContent = q.question;
    
    const choicesDiv = document.getElementById("answer-choices");
    choicesDiv.innerHTML = "";
    q.choices.forEach((choice, i) => {
        const choiceDiv = document.createElement("div");
        const radio = document.createElement("input");
        radio.type = "radio";
        radio.name = `q${questionIndex}`;
        radio.id = `choice${i}`;
        radio.onclick = () => {
            userAnswers[questionIndex] = choice;
            document.getElementById("advance-btn").disabled = false;
        };
        const label = document.createElement("label");
        label.htmlFor = `choice${i}`;
        label.textContent = choice;
        choiceDiv.appendChild(radio);
        choiceDiv.appendChild(label);
        choicesDiv.appendChild(choiceDiv);
    });

    const advanceBtn = document.getElementById("advance-btn");
    advanceBtn.textContent = questionIndex === maxQuestions - 1 ? "Submit" : "Next";
    advanceBtn.disabled = !userAnswers[questionIndex];
    advanceBtn.onclick = moveToNext;
}

function updateProgressBar() {
    const progressBar = document.getElementById("progress-bar");
    progressBar.innerHTML = "";
    for (let i = 0; i < maxQuestions; i++) {
        const indicator = document.createElement("div");
        indicator.className = "q-indicator" + (i < questionIndex ? " completed" : i === questionIndex ? " active" : "");
        indicator.textContent = `Q${i + 1}`;
        progressBar.appendChild(indicator);
    }
}

function runTimer() {
    setInterval(() => {
        if (remainingTime <= 0) {
            submitAssessment(); // Auto-submit when time is up
        } else {
            remainingTime--;
            const mins = Math.floor(remainingTime / 60);
            const secs = String(remainingTime % 60).padStart(2, "0");
            document.getElementById("time-remaining").textContent = `Time Left: ${mins}:${secs}`;
            
            if (remainingTime === 300 && !timeWarningShown) {
                showTimeWarning("Only 5 minutes remaining!");
                timeWarningShown = true;
            }
        }
    }, 1000);
}

function moveToNext() {
    if (questionIndex < maxQuestions - 1) {
        questionIndex++;
        showQuestion();
        updateProgressBar();
    } else {
        submitAssessmentFull();
    }
}

function calculateScoreDetails() {
    let correct = 0;
    const totalQuestions = 50; // Fixed denominator for total questions

    // Count correct answers based on userAnswers
    for (let i = 0; i < totalQuestions; i++) {
        if (userAnswers[i] === assessmentQuestionsForExam[i].answer) {
            correct++;
        }
    }

    // Score is always out of 50 (total questions)
    const score = `${correct}/${totalQuestions}`;
    const percentage = (correct / totalQuestions) * 100; // Percentage based on total questions

    return { score, correct, percentage };
}

function submitAssessment() {
    isSubmitting = true;
    const { score, percentage } = calculateScoreDetails();
    const email = document.body.getAttribute("data-email");
    const data = `email=${encodeURIComponent(email)}&score=${encodeURIComponent(score)}`;

    fetch("fullstack.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: data
    })
    .then(response => {
        if (!response.ok) throw new Error("Network response was not ok: " + response.status);
        return response.text();
    })
    .then(text => {
        const data = JSON.parse(text);
        if (data.status === "success") {
            examCompleted = true; // Mark exam as completed
            showSuccessMessage(`Exam successfully submitted`);
            setTimeout(() => {
                document.exitFullscreen().then(() => {
                    window.close(); // Close the window after exiting fullscreen
                }).catch(err => {
                    console.error("Error exiting fullscreen:", err);
                    window.close(); // Attempt to close anyway
                });
            }, 3000);
        } else {
            throw new Error(data.message || "Failed to submit exam");
        }
    })
    .catch(error => {
        console.error("Submission error:", error);
        alert("Failed to submit exam. Please try again.");
        isSubmitting = false;
    });
}

function submitAssessmentFull() {
    isSubmitting = true;
    const { score, percentage } = calculateScoreDetails();
    const email = document.body.getAttribute("data-email");
    const data = `email=${encodeURIComponent(email)}&score=${encodeURIComponent(score)}`;

    fetch("fullstack.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: data
    })
    .then(response => {
        if (!response.ok) throw new Error("Network response was not ok: " + response.status);
        return response.text();
    })
    .then(text => {
        const data = JSON.parse(text);
        if (data.status === "success") {
            examCompleted = true; // Mark exam as completed
            showSuccessMessage(`Exam successfully submitted`);
            setTimeout(() => {
                document.exitFullscreen().then(() => {
                    window.close(); // Close the window after exiting fullscreen
                }).catch(err => {
                    console.error("Error exiting fullscreen:", err);
                    window.close(); // Attempt to close anyway
                });
            }, 3000);
        } else {
            throw new Error(data.message || "Failed to submit exam");
        }
    })
    .catch(error => {
        console.error("Submission error:", error);
        alert("Failed to submit exam. Please try again.");
        isSubmitting = false;
    });
}

function handleSwitch() {
    const currentTime = Date.now();
    if (currentTime - lastSwitchTime < 500) return;
    lastSwitchTime = currentTime;

    if (document.hidden || document.hasFocus() === false) {
        warningCount++;
        if (warningCount >= maxWarnings) {
            submitAssessment();
        } else {
            showAlert(
                'Warning: Do not switch tabs or browsers during the exam.',
                null,
                hideAlert
            );
        }
    }
}

function setupEndButton() {
    document.getElementById("end-assessment").onclick = () => {
        const answered = Object.keys(userAnswers).length;
        if (answered === maxQuestions) {
            showAlert("Do you want to submit the exam?", submitAssessmentFull, hideAlert);
        } else {
            showAlert(
                "You haven't answered all questions. Force submit or cancel?",
                null,
                null,
                submitAssessmentFull,
                hideAlert
            );
        }
    };
}

function showAlert(msg, submitFn, stayFn, forceFn, cancelFn) {
    const alertBox = document.getElementById("alert-box");
    document.getElementById("alert-text").textContent = msg;
    const submitBtn = document.getElementById("alert-submit");
    const stayBtn = document.getElementById("alert-stay");
    const forceBtn = document.getElementById("alert-force");
    const cancelBtn = document.getElementById("alert-cancel");

    submitBtn.classList.add("hidden");
    stayBtn.classList.add("hidden");
    forceBtn.classList.add("hidden");
    cancelBtn.classList.add("hidden");

    if (submitFn && stayFn) {
        submitBtn.classList.remove("hidden");
        stayBtn.classList.remove("hidden");
        submitBtn.onclick = submitFn;
        stayBtn.onclick = stayFn;
    } else if (forceFn && cancelFn) {
        forceBtn.classList.remove("hidden");
        cancelBtn.classList.remove("hidden");
        forceBtn.onclick = forceFn;
        cancelBtn.onclick = cancelFn;
    } else if (submitFn) {
        submitBtn.classList.remove("hidden");
        submitBtn.onclick = submitFn;
    } else if (stayFn) {
        stayBtn.classList.remove("hidden");
        stayBtn.onclick = stayFn;
    }
    alertBox.classList.remove("hidden");
}

function hideAlert() {
    document.getElementById("alert-box").classList.add("hidden");
}

function submitAssessmentForRefresh() {
    isSubmitting = true;
    const { score, percentage } = calculateScoreDetails();
    const email = document.body.getAttribute("data-email");
    const data = `email=${encodeURIComponent(email)}&score=${encodeURIComponent(score)}`;

    fetch("fullstack.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: data
    })
    .then(response => {
        if (!response.ok) throw new Error("Network response was not ok: " + response.status);
        return response.text();
    })
    .then(text => {
        const data = JSON.parse(text);
        if (data.status === "success") {
            examCompleted = true; // Mark exam as completed
            showSuccessMessage(`Exam successfully submitted`);
            setTimeout(() => {
                document.exitFullscreen().then(() => {
                    window.close(); // Close the window after exiting fullscreen
                }).catch(err => {
                    console.error("Error exiting fullscreen:", err);
                    window.close(); // Attempt to close anyway
                });
            }, 3000);
        } else {
            throw new Error(data.message || "Failed to submit exam");
        }
    })
    .catch(error => {
        console.error("Submission error:", error);
        alert("Failed to submit exam due to refresh. Please try again.");
        isSubmitting = false;
        refreshAttempted = false;
    });
}

function showSuccessMessage(message) {
    const successDiv = document.createElement("div");
    successDiv.id = "success-message";
    successDiv.textContent = message;
    successDiv.style.position = "fixed";
    successDiv.style.top = "20px";
    successDiv.style.left = "50%";
    successDiv.style.transform = "translateX(-50%)";
    successDiv.style.backgroundColor = "green";
    successDiv.style.color = "white";
    successDiv.style.padding = "10px 20px";
    successDiv.style.borderRadius = "5px";
    successDiv.style.zIndex = "1000";
    successDiv.style.boxShadow = "0 2px 10px rgba(0, 0, 0, 0.2)";
    document.body.appendChild(successDiv);

    setTimeout(() => {
        if (successDiv.parentNode) document.body.removeChild(successDiv);
    }, 3000);
}

function showTimeWarning(message) {
    const warningDiv = document.createElement("div");
    warningDiv.id = "time-warning";
    warningDiv.textContent = message;
    warningDiv.style.position = "fixed";
    warningDiv.style.top = "20px";
    warningDiv.style.left = "50%";
    warningDiv.style.transform = "translateX(-50%)";
    warningDiv.style.backgroundColor = "red";
    warningDiv.style.color = "white";
    warningDiv.style.padding = "10px 20px";
    warningDiv.style.borderRadius = "5px";
    warningDiv.style.zIndex = "1000";
    warningDiv.style.boxShadow = "0 2px 10px rgba(0, 0, 0, 0.2)";
    document.body.appendChild(warningDiv);

    setTimeout(() => {
        if (warningDiv.parentNode) document.body.removeChild(warningDiv);
    }, 3000);
}

// Start the assessment
launchAssessment();