<form [formGroup]="formGroup" style="max-width: 400px; margin-right: auto;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Name</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Name" formControlName="name">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Company</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Company" formControlName="company">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Place</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Place" formControlName="place">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Language</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Language" formControlName="language">
      </mat-form-field>
    </div>
  
    <button mat-raised-button color="primary" type="submit">Submit</button>
  </form>
  
