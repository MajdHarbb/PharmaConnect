<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/title.svg"/>

<div align="center">
> Hello world! This is the project’s summary that describes the project plain and simple, limited to the space available. 

**[PROJECT PHILOSOPHY](https://github.com/julescript/well_app#-project-philosophy) • [WIREFRAMES](https://github.com/julescript/well_app#-wireframes) • [TECH STACK](https://github.com/julescript/well_app#-tech-stack) • [IMPLEMENTATION](https://github.com/julescript/well_app#-impplementation) • [HOW TO RUN?](https://github.com/julescript/well_app#-how-to-run)**

</div>

<br><br>


<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/projectphilosophy.svg"/>

> PharmaConnect is an app to combat medicine shortages in Lebanon. PharmaConnect is more than an app or a practice of code; this app serves a good cause, reduces the impact of the disastrous medicine shortages, and maybe even, saves a soul. 
> 
> PharmaConnect connects medicine seekers with pharmacy owners. For example, instead of driving across the entire country to find your medicine, you can simply register, create a post detailing the medicine that you're looking for ie. with a caption and a picture and you'll get a reply from all the pharmacies that have your requested medicine. 

### User Stories
Patient stories:
- As a patient, I want to sign up, so that I can use PharmaConnect to find my medicine.
- As a patient, I want to create a post, so that I can notify all pharmacies about a medicine.
- As a patient, I want to see all pharmacies, so that I can find quick links to their location and contact information.
- As a patient, I want to get replies from pharmacies on each post, so that I can go to the nearest pharmacy.
- As a patient, I want to edit and delete my posts, so that I can remove unwanted replies.
- As a patient, I want to edit my personal information, so that I can have more control over my profile.
- As a patient, I want to get replies from pharmacies on each post, so that I can go to the nearest pharmacy.
- 
Pharmacy owner stories:
- As a pharmacy owner, I want to sign up, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to sign up, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to enter my extact location on google maps, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to upload a photo of my license, so that I can provide authenticity.
- As a pharmacy owner, I want to see all posts from patients, so that I can notify them if I have their request.
- As a pharmacy owner, I want to edit my personal information, so that I can have more control over my profile.

Admin stories: 
- As an admin, I want to see statistics on the app, so I can benefit from these information for future use.
- As an admin, I want to see to see a list of all users, so I can scale my app.
- As an admin, I want to see to edit user information, so I can have more control.
- As an admin, I want to see all posts, so I remove unwanted ones.
<br><br>

<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/wireframes.svg"/>

> This design was planned before on paper, then moved to Figma app for the fine details.
Note that i didn't use any styling library or theme, all from scratch and using pure css modules

<h2>Figma Wireframes</h2>
<table>
  <tr>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/welcome.png" /></td>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/welcome2.png" /></td>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/signuppage.png" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/patienthome.png" /></td>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/userpharmacies.png"/></td>
    <td><img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/figma/userprofile.png"/></td>
  </tr>
</table>

<br><br>

<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/tech.svg"/>

Here's a brief high-level overview of the tech stack the Well app uses:

- For the app, this project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For the admin panel website, this project uses the [React JS](https://reactjs.org/). React is a free and open-source front-end JavaScript library for building user interfaces based on UI components. It is maintained by Meta and a community of individual developers and companies.
- For persistent storage (database), the app uses the [Laravel 8](https://laravel.com/) package which allows the app to create a custom storage schema and save it to a local database.
- The app uses the font ["Nunito"](https://fonts.google.com/specimen/Nunito) as its main font, and the design of the app adheres to the material design guidelines.



<br><br>
<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/implementation.svg"/>

> Uing the above mentioned tecch stacks and the wireframes build with figma from the user sotries we have, the implementation of the app is shown as below, these are screenshots from the real app
<h2>Welocme & Sign Up</h2>
<table>
  <tr>
    <td><img width="300" height="400"  src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/welcome1.jpg" /></td>
    <td><img width="300" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/welcome2.jpg" /></td>
    <td><img width="300" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/welcome3.jpg" /></td>
  </tr>
  <tr>
    <td><img width="400" height="500" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/patientOrPharmacy.jpg" /></td>
    <td><img width="400" height="500" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/pharmacySignup.jpg"/></td>
    <td><img width="400" height="500" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/patientSignup.jpg"/></td>
  </tr>
</table>

<br/>
<h2>Patient UI</h2>
<table>
  <tr>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/maphome.jpg" /></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/pharmacies.jpg" /></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/post.gif" /></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/edit.gif" /></td>
  </tr>
  <tr>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/delete.gif" /></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/notifications.gif"/></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/pic.gif"/></td>
    <td><img width="200" height="400" src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/screenshots/App/name.gif" /></td>
  </tr>
</table>

<h2>Pharmacy UI</h2>
<br/>

| Home  | Reply  |Profile  |
| -----------------| -----|-----|
| ![Home](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-40-52-497_com.example.pharmaconnectflutter.jpg) | ![Reply](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/Screenshot_2022-04-04-20-17-07-122_com.example.pharmaconnectflutter.jpg) | ![Profile](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/Screenshot_2022-04-04-20-17-17-292_com.example.pharmaconnectflutter.jpg) |

<h2>React Admin Panel</h2>
<br/>

| Patients  | Edit Patient  |
| -----------------| -----|
| ![Patients](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/login.png) | ![Edit](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/home.png) |

| Patients  | Edit Patient  |
| -----------------| -----|
| ![Patients](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/users.png) | ![Edit](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/edit%20user.png) |

| Create User  | Pharmacies  |
| -----------------| -----|
| ![Patients](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/create%20user.png) | ![Edit](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/pharmacies.png) |

| Posts  | Messages  |
| -----------------| -----|
| ![Posts](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/posts.png) | ![Messages](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/react/messages.png) |



<br><br>
<img src="https://github.com/MajdHarbb/PharmaConnect/blob/master/README/titles/run.svg"/>


> This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```
