<h2>Majd Harb</h2>
<h1>PharmaConnect</h1>

<div align="center">

> Hello world! This is the project’s summary that describes the project plain and simple, limited to the space available. 

**[PROJECT PHILOSOPHY](https://github.com/julescript/well_app#-project-philosophy) • [WIREFRAMES](https://github.com/julescript/well_app#-wireframes) • [TECH STACK](https://github.com/julescript/well_app#-tech-stack) • [IMPLEMENTATION](https://github.com/julescript/well_app#-impplementation) • [HOW TO RUN?](https://github.com/julescript/well_app#-how-to-run)**

</div>

<br><br>


<img src="./readme/title2.svg"/>

> PharmaConnect is an app to combat medicine shortages in Lebanon. PharmaConnect is more than an app or a practice of code; this app serves a good cause, reduces the impact of the disastrous medicine shortages, and maybe even, saves a soul. 
> 
> PharmaConnect connects medicine seekers with pharmacy owners. For example, instead of driving across the entire country to find your medicine, you can simply register, create a post detailing the medicine that you're looking for ie. with a caption and a picture and you'll get a reply from all the pharmacies that have your requested medicine. 

### User Stories
- As a patient, I want to sign up, so that I can use PharmaConnect to find my medicine.
- As a patient, I want to create a post, so that I can notify all pharmacies about a medicine.
- As a patient, I want to see all pharmacies, so that I can find quick links to their location and contact information.
- As a patient, I want to get replies from pharmacies on each post, so that I can go to the nearest pharmacy.
- As a patient, I want to edit and delete my posts, so that I can remove unwanted replies.
- As a patient, I want to edit my personal information, so that I can have more control over my profile.
- As a patient, I want to get replies from pharmacies on each post, so that I can go to the nearest pharmacy.
- As a pharmacy owner, I want to sign up, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to sign up, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to enter my extact location on google maps, so that I can connect with medicine seeker.
- As a pharmacy owner, I want to upload a photo of my license, so that I can provide authenticity.
- As a pharmacy owner, I want to see all posts from patients, so that I can notify them if I have their request.
- As a pharmacy owner, I want to edit my personal information, so that I can have more control over my profile.
<br><br>

<img src="./readme/title3.svg"/>

> This design was planned before on paper, then moved to Figma app for the fine details.
Note that i didn't use any styling library or theme, all from scratch and using pure css modules

| Welcome  | welcome  |Sign Up  |
| -----------------| -----|-----|
| ![Welcome](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/welcome.png) | ![welcome](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/welcome2.png) | ![Sign Up](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/signuppage.png) |

#
| Home  | Pharmacies  |Profile  |
| ---------| -----|-----|
| ![Home](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/patienthome.png) | ![Pharmacies](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/userpharmacies.png) | ![Profile](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/figma/userprofile.png) |


<br><br>

<img src="./readme/title4.svg"/>

Here's a brief high-level overview of the tech stack the Well app uses:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For persistent storage (database), the app uses the [Laravel 8](https://laravel.com/) package which allows the app to create a custom storage schema and save it to a local database.
- The app uses the font ["Nunito"](https://fonts.google.com/specimen/Nunito) as its main font, and the design of the app adheres to the material design guidelines.



<br><br>
<img src="./readme/title5.svg"/>

> Uing the above mentioned tecch stacks and the wireframes build with figma from the user sotries we have, the implementation of the app is shown as below, these are screenshots from the real app

| Welcome  | welcome  |Welcome  |
| -----------------| -----|-----|
| ![Welcome](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-02-231_com.example.pharmaconnectflutter.jpg) | ![Welcome](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-06-626_com.example.pharmaconnectflutter.jpg) | ![Sign Up](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-10-320_com.example.pharmaconnectflutter.jpg) |

| Pharmacy or Patient?  | Pharmacy Sign Up  |Patient Sign Up  |
| -----------------| -----|-----|
| ![Pharmacy or Patient?](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-13-862_com.example.pharmaconnectflutter.jpg) | ![Pharmacy](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-30-506_com.example.pharmaconnectflutter.jpg) | ![Patient Up](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-37-17-727_com.example.pharmaconnectflutter.jpg) |

| Posts  | Notifications  |
| -----------------| -----|-----|
| ![Posts](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-40-07-980_com.example.pharmaconnectflutter.jpg) | ![Notifications](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-40-11-384_com.example.pharmaconnectflutter.jpg) |

| -----------------| -----|
| ![Pharmacy](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-40-52-497_com.example.pharmaconnectflutter.jpg) | ![Profile](https://github.com/MajdHarbb/PharmaConnect-Flutter/blob/master/readme/implementation/Screenshot_2022-04-04-09-40-15-994_com.example.pharmaconnectflutter.jpg) |

<br><br>
<img src="./readme/title6.svg"/>


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

