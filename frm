.npm install bootstrap
"styles": [
  "node_modules/bootstrap/dist/css/bootstrap.min.css",
  "src/styles.css"
]
css
/* Full width + flex behavior */
.main-container {
  width: 100vw;
}

/* Each row: horizontal flex container */
.custom-row {
  display: flex;
  width: 100%;
  min-height: 15vh;
  margin-bottom: 5px;
}

/* Each column: equal width, remove borders */
.custom-col {
  flex: 1;
  padding: 10px;
  overflow: auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

/* Row height settings */
.row-1 { min-height: 35vh; }
.row-2 { min-height: 20vh; }
.row-3 { min-height: 20vh; }
.row-4 { min-height: 12vh; }
.row-5 { min-height: 15vh; }
.row-6 { min-height: 15vh; }

/* Background color examples */
.row-1-div-1 { background-color: #ffffff; }
.row-1-div-2 { background-color: #ffffff; }
.row-1-div-3 { background-color: #ffffff; }
.row-1-div-4 { background-color: #ffffff; }
.row-1-div-5 { background-color: #ffffff; }
.row-1-div-6 { background-color: #ffffff; }

/* Unique styling for each card */
.card-top {
  width: 100%;
  height: 45%;
  margin-bottom: 5%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}

.card-bottom {
  width: 100%;
  height: 45%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #e2e3e5;
}

.business-card {
  background-color: #4169E1;  /* Bootstrap primary #4169E1 */
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 40%;              /* Adjust as needed */
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.systems-interaction-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.card-grid-2x3 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 10px;
  width: 100%;
  height: 100%;
}

/* Base card styles */
.card-grid-2x3 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 500;
  font-size: 0.95rem;
  border-radius: 8px;
  height: 100%;
}

/* Unique card colors */
.card-1 { background-color: #007bff; } /* #4169E1 */
.card-2 { background-color: #28a745; } /* green */
.card-3 { background-color: #fd7e14; } /* orange */
.card-4 { background-color: #6f42c1; } /* purple */
.card-5 { background-color: #dc3545; } /* red */
.card-6 { background-color: #17a2b8; } /* teal */

.row-2 {
  min-height: 20vh;
  position: relative;         /* Enable absolute positioning inside */
  overflow: visible;          /* Allow overflow across cols */
  z-index: 0;
}

.row-2-div-2 {
  position: relative;
  overflow: visible; /* Important to allow content to overflow into Div 3 */
}
.bridge-card {
  position: absolute;
  bottom: 2px;              /* Appear just below the 2x3 grid */
  left: 50%;                  /* Start in middle of Div 2 */
  transform: translateX(10%); /* Nudge right into Div 3 */
  width: 130%;                /* Stretch across Div 2 + part of Div 3 */
  height: 40px;
  background-color: #ffc107;  /* Yellow */
  color: #212529;
  border-radius: 10px;
  text-align: center;
  line-height: 40px;
  font-weight: bold;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  z-index: 5;
}
.invisiblecard{
  visibility: hidden;
}

/* Wrapper for 2 horizontal cards */
.card-pair-horizontal {
  display: flex;
  width: 100%;
  height: 100%;
  gap: 10px;
  justify-content: center;
  align-items: center;
}

/* Base style for both horizontal cards */
.horizontal-card {
  flex: 1;
  height: 30px; /* adjust as needed */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 500;
  font-size: 0.95rem;
  color: white;
}

/* Unique colors (optional) */
.card-left {
  background-color: #ffc107; /* teal */
}

.card-right {
  background-color: #4169E1; /* purple */
}


.single-card {
  width: 100%;
  height: 30%;
  display: flex;
  border-radius: 10px;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  color: white;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

/* Unique styles for each */
.card-div5 {
  background-color: #17a2b8; /* teal/cyan */
}

.card-div6 {
  background-color: #dc3545; /* red */
}

.administration-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.analytics-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.peripherals-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
/* Regular columns keep default flex */
.row-3-div-1,
.row-3-div-4,
.row-3-div-5,
.row-3-div-6 {
  flex: 1;
}

/* Combined div spans double width */
.row-3-div-2-3 {
  flex: 2;
  padding: 10px;
  background-color: #ffd966; /* Light yellow background for visibility */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}
.card-grid-3x2 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 100%;
}

/* Base card styles */
.card-grid-3x2 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 500;
  font-size: 0.95rem;
  border-radius: 8px;
  height: 100%;
}

/* Unique card colors */
.card-a { background-color: #007bff; } /* Blue */
.card-b { background-color: #28a745; } /* Green */
.card-c { background-color: #fd7e14; } /* Orange */
.card-d { background-color: #6f42c1; } /* Purple */
.card-e { background-color: #dc3545; } /* Red */
.card-f { background-color: #17a2b8; } /* Teal */


.card-top-3-4,
.card-bottom-3-4 {
  width: 100%;
  height: 45%;
  margin: 2.5% 0;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
}

/* Unique background colors */
.card-top-3-4 {
  background-color: #20c997; /* Teal green */
}

.card-bottom-3-4 {
  background-color: #ff6f61; /* Coral */
}

/* 3x2 grid for row-3-div-5 */
.card-grid-3x2-div5 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 60%;
}

/* Base card style */
.card-grid-3x2-div5 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 100%;
}

/* Unique colors for each card */
.card-5a { background-color: #1abc9c; }  /* turquoise */
.card-5b { background-color: #e67e22; }  /* carrot */
.card-5c { background-color: #9b59b6; }  /* amethyst */
.card-5d { background-color: #f39c12; }  /* orange */
.card-5e { background-color: #2ecc71; }  /* emerald */
.card-5f { background-color: #34495e; }  /* wet asphalt */

/* 2x2 grid for row-3-div-6 */
.card-grid-2x2-div6 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 60%;
}

/* Base style for each card */
.card-grid-2x2-div6 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 100%;
}

/* Unique colors */
.card-6a { background-color: #ff4757; }  /* red */
.card-6b { background-color: #1e90ff; }  /* blue */
.card-6c { background-color: #2ed573; }  /* green */
.card-6d { background-color: #ffa502; }  /* orange */

/* Row 4 - keep as is */
.row-4 {
  min-height: 12vh;
}

/* Div 1 keeps its standard width */
.row-4-div-1 {
  flex: 1;
}

/* Combined Div 2–6 */
.row-4-div-2to6 {
  flex: 5;
  padding: 10px;
  background-color: #f0f8ff; /* Alice blue for visibility */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

/* Wrapper for horizontal cards */
.flex-cards-wrapper {
  display: flex;
  flex-wrap: nowrap;
  width: 100%;
  gap: 10px;
  justify-content: space-between;
}

/* Card styling */
.flex-card {
  padding: 8px 16px;
  border-radius: 8px;
  text-align: center;
  font-weight: 600;
  color: white;
  white-space: nowrap;
  flex-shrink: 1;       /* allow squeezing */
  flex-grow: 1;         /* allow growing */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Unique card background colors */
.card-a { background-color: #007bff; }  /* Blue */
.card-b { background-color: #28a745; }  /* Green */
.card-c { background-color: #fd7e14; }  /* Orange */
.card-d { background-color: #6f42c1; }  /* Purple */
.card-e { background-color: #20c997; }  /* Teal */
.card-f { background-color: #dc3545; }  /* Red */
.card-g { background-color: #17a2b8; }  /* Cyan */
.card-h { background-color: #ffc107; }  /* Yellow */

/* Wrapper */
.card-grid-2x2-with-footer {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  gap: 10px;
}

/* Grid Section */
.grid-section {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  flex-grow: 1;
}

/* Base card style */
.grid-section .card,
.card-5-2-footer {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 100%;
}

/* Unique colors for grid cards */
.card-5-2a { background-color: #1abc9c; }
.card-5-2b { background-color: #3498db; }
.card-5-2c { background-color: #9b59b6; }
.card-5-2d { background-color: #f39c12; }

/* Footer card */
.card-5-2-footer {
  background-color: #e74c3c;
  height: 50px;
}
/* 2x2 grid for row-5-div-3 */
.card-grid-2x2-div5-3 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 100%;
}

/* Base card styling */
.card-grid-2x2-div5-3 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 100%;
}

/* Unique card colors */
.card-5-3a { background-color: #e67e22; }  /* carrot orange */
.card-5-3b { background-color: #16a085; }  /* green blue */
.card-5-3c { background-color: #8e44ad; }  /* purple */
.card-5-3d { background-color: #c0392b; }  /* red */

/* Horizontal card pair for row-5-div-4 */
.card-pair-row-5-4 {
  display: flex;
  width: 100%;
  height: 100%;
  gap: 10px;
}

/* Base card styling */
.card-pair-row-5-4 .card {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.95rem;
  color: white;
  border-radius: 10px;
}

/* Unique card colors */
.card-left-5-4 { background-color: #27ae60; }   /* green */
.card-right-5-4 { background-color: #2980b9; }  /* blue */

/* Container for stack layout */
.card-stack-5-5 {
  display: flex;
  flex-direction: column;
  gap: 10px;
  width: 100%;
  height: 100%;
}

/* Top row pair */
.card-pair-5-5 {
  display: flex;
  gap: 10px;
}

/* Base card styles */
.card-pair-5-5 .card,
.card-5-5c {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.95rem;
  color: white;
  border-radius: 10px;
  height: 100%;
}

/* Unique card colors */
.card-5-5a { background-color: #8e44ad; }  /* purple */
.card-5-5b { background-color: #e67e22; }  /* orange */
.card-5-5c {
  background-color: #2ecc71;              /* green */
  height: 50px;                            /* set height for bottom card */
}
/* Vertical stacked cards in row-5-div-6 */
.row-5-div-6 .card {
  width: 100%;
  height: 45%;
  margin: 2.5% 0;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.95rem;
  color: white;
}

/* Unique background colors */
.card-5-6a {
  background-color: #f39c12; /* orange */
}

.card-5-6b {
  background-color: #3498db; /* blue */
}

/* Row 6 base height (copied from Row 1) */
.row-6 {
  min-height: 35vh;
}

/* Background color examples (duplicate of row-1-div-x) */
.row-6-div-1 { background-color: #ffffff; }
.row-6-div-2 { background-color: #ffffff; }
.row-6-div-3 { background-color: #ffffff; }
.row-6-div-4 { background-color: #ffffff; }
.row-6-div-5 { background-color: #ffffff; }
.row-6-div-6 { background-color: #ffffff; }

/* Unique styling for each card in Row 6 (copied from Row 1) */
.row-6-div-1 .business-card {
  background-color: #007bff;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 40%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

/* Row 6 Top & Bottom card styles */
.row-6-div-2 .card-top,
.row-6-div-3 .card-top,
.row-6-div-4 .card-top,
.row-6-div-5 .card-top,
.row-6-div-6 .card-top {
  width: 100%;
  height: 45%;
  margin-bottom: 5%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}

.row-6-div-2 .card-bottom,
.row-6-div-3 .card-bottom,
.row-6-div-4 .card-bottom,
.row-6-div-5 .card-bottom,
.row-6-div-6 .card-bottom {
  width: 100%;
  height: 45%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #e2e3e5;
}
.card:hover {
  cursor: pointer;
  opacity: 0.9;
  transition: all 0.2s;
}




















html
<!-- layout.component.html -->
<div class="main-container">
  <div class="custom-row row-1">
    <div class="custom-col row-1-div-1">
      <div class="card business-card">
        <div class="card-body">
          Key Business Transaction
        </div>
      </div>
    </div>
    <div class="custom-col row-1-div-2">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-3">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-4">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-5">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-6">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>

  </div>

  <div class="custom-row row-2">
    <div class="custom-col row-2-div-1">
      <div class="card systems-interaction-card">
        <div class="card-body">
          Systems Interaction
        </div>
      </div>
    </div>
    <div class="custom-col row-2-div-2">Div 2
      <div class="card-grid-2x3">

        
        <div 
        class="card card-1"
        [title]="cardDescriptions['card1']">
        <div class="card-body">Card 1</div>
      </div>
    
      <!-- Card 2 with tooltip -->
      <div 
        class="card card-2"
        [title]="cardDescriptions['card2']">
        <div class="card-body">Card 2</div>
      </div>
        <div class="card card-3"><div class="card-body">Card 3</div></div>
        <div class="card card-4"><div class="card-body">Card 4</div></div>
        <div class="card card-5"><div class="card-body">Card 5</div></div>
        <div class="card card-6 invisiblecard"><div class="card-body">Card 6</div></div>
      </div>
      <div class="bridge-card">Admin</div>
    </div>
    <div class="custom-col row-2-div-3">Div 3
      <div class="card-pair-horizontal">
        <div class="card horizontal-card card-left">
          <div class="card-body">Left Card</div>
        </div>
        <div class="card horizontal-card card-right">
          <div class="card-body">Right Card</div>
        </div>
      </div>
    </div>
    <div class="custom-col row-2-div-4">Div 4</div>
    <div class="custom-col row-2-div-5">Div 5  
      <div class="card single-card card-div5">
      <div class="card-body">Operations</div>
    </div></div>
    <div class="custom-col row-2-div-6">Div 6
      <div class="card single-card card-div6">
        <div class="card-body">Monitoring</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-3">
    <div class="custom-col row-3-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Administration
        </div>
      </div>
    </div>
    <div class="custom-col row-3-div-2-3">
      Policy Admin
      <div class="card-grid-3x2">
        <div class="card card-a"><div class="card-body">Card A</div></div>
        <div class="card card-b"><div class="card-body">Card B</div></div>
        <div class="card card-c"><div class="card-body">Card C</div></div>
        <div class="card card-d"><div class="card-body">Card D</div></div>
        <div class="card card-e"><div class="card-body">Card E</div></div>
        <div class="card card-f"><div class="card-body">Card F</div></div>
      </div>
    </div>
    <div class="custom-col row-3-div-4">Div 4
      <div class="card card-top-3-4">
        <div class="card-body">Top Card</div>
      </div>
      <div class="card card-bottom-3-4">
        <div class="card-body">Bottom Card</div>
      </div>
    </div>
    <div class="custom-col row-3-div-5">Producer Mgmt
      <div class="card-grid-3x2-div5">
        <div class="card card-5a"><div class="card-body">Card A</div></div>
        <div class="card card-5b"><div class="card-body">Card B</div></div>
        <div class="card card-5c"><div class="card-body">Card C</div></div>
        <div class="card card-5d"><div class="card-body">Card D</div></div>
        <div class="card card-5e"><div class="card-body">Card E</div></div>
        <div class="card card-5f"><div class="card-body">Card F</div></div>
      </div>
    </div>
    <div class="custom-col row-3-div-6">Billing Payments Processing
      <div class="card-grid-2x2-div6">
        <div class="card card-6a"><div class="card-body">Card A</div></div>
        <div class="card card-6b"><div class="card-body">Card B</div></div>
        <div class="card card-6c"><div class="card-body">Card C</div></div>
        <div class="card card-6d"><div class="card-body">Card D</div></div>
      </div>
    </div>
  </div>

  <div class="custom-row row-4">
    <div class="custom-col row-4-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Analytics
        </div>
      </div>
    </div>
    <div class="custom-col row-4-div-2to6">
      <div class="flex-cards-wrapper">
        <div class="flex-card card-a">Analytics</div>
        <div class="flex-card card-b">Ops</div>
        <div class="flex-card card-c">Compliance</div>
        <div class="flex-card card-d">Security</div>
        <div class="flex-card card-e">Dev</div>
        <div class="flex-card card-f">QA</div>
        <div class="flex-card card-g">Infra Mgmt</div>
        <div class="flex-card card-h">Support</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-5">
    <div class="custom-col row-5-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Peripherals Systems
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-2">Div 2
      <div class="card-grid-2x2-with-footer">
        <div class="grid-section">
          <div class="card card-5-2a"><div class="card-body">Card A</div></div>
          <div class="card card-5-2b"><div class="card-body">Card B</div></div>
          <div class="card card-5-2c"><div class="card-body">Card C</div></div>
          <div class="card card-5-2d"><div class="card-body">Card D</div></div>
        </div>
        <div class="card card-5-2-footer">
          <div class="card-body">Footer Card</div>
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-3">Accounting
      <div class="card-grid-2x2-div5-3">
        <div class="card card-5-3a"><div class="card-body">Card A</div></div>
        <div class="card card-5-3b"><div class="card-body">Card B</div></div>
        <div class="card card-5-3c"><div class="card-body">Card C</div></div>
        <div class="card card-5-3d"><div class="card-body">Card D</div></div>
      </div>
    </div>
    <div class="custom-col row-5-div-4">Div 4
      <div class="card-pair-row-5-4">
        <div class="card card-left-5-4"><div class="card-body">Left Card</div></div>
        <div class="card card-right-5-4"><div class="card-body">Right Card</div></div>
      </div>
    </div>
    <div class="custom-col row-5-div-5">Div 5
      <div class="card-stack-5-5">
        <!-- Top Row -->
        <div class="card-pair-5-5">
          <div class="card card-5-5a"><div class="card-body">Card A</div></div>
          <div class="card card-5-5b"><div class="card-body">Card B</div></div>
        </div>
    
        <!-- Bottom Full Width Card -->
        <div class="card card-5-5c">
          <div class="card-body">Full Width Card</div>
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-6">Div 6
      <div class="card card-5-6a">
        <div class="card-body">Top Card</div>
      </div>
      <div class="card card-5-6b">
        <div class="card-body">Bottom Card</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-6">
    <div class="custom-col row-6-div-1">
      <div class="card business-card">
        <div class="card-body">
          Key Business Transaction
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-2">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-3">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-4">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-5">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-6">
      <div class="card card-top">
        <div class="card-body">
          Top Card Content
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bottom Card Content
        </div>
      </div>
    </div>
  </div>
  
</div>

















ts
import { Component } from '@angular/core';

@Component({
  selector: 'app-jim2',
  
 
  templateUrl: './jim2.component.html',
  styleUrl: './jim2.component.css'
})
export class Jim2Component {
  cardDescriptions: { [key: string]: string } = {
    card1: 'This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.',
    card2: 'This is the description for Card 2. It displays system health metrics.'
  };
}












