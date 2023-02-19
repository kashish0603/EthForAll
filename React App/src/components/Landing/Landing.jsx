import React from "react";
import { Link } from "react-router-dom";
import "../Landing/Landing.css";

export const Landing = () => {
	return (
		<div className="landing">
			<div className="container grid">
				<div className="content">
					<h1>
						Invest in Bonds offering{" "}
						<span className="green">9-11% fixed returns</span>.
					</h1>
					<p>
						Earn fixed returns on carefully curated senior secured
						bonds that beat inflation, starting at just ₹10,000.
					</p>
					<Link className="investbtn" to="dashboard">
						<button className="invest">
							Explore bonds to Invest
						</button>
					</Link>
				</div>
				<img className="man" src="/first.jpg" alt="man" />
			</div>
			<div className="container">
				<div className="stats">
					<div className="people">
						<svg
							className="people-svg"
							focusable="false"
							aria-hidden="true"
							viewBox="0 0 24 24"
							data-testid="GroupsIcon"
							// style="font-size: 40px;"
						>
							<path d="M12 12.75c1.63 0 3.07.39 4.24.9 1.08.48 1.76 1.56 1.76 2.73V18H6v-1.61c0-1.18.68-2.26 1.76-2.73 1.17-.52 2.61-.91 4.24-.91zM4 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm1.13 1.1c-.37-.06-.74-.1-1.13-.1-.99 0-1.93.21-2.78.58C.48 14.9 0 15.62 0 16.43V18h4.5v-1.61c0-.83.23-1.61.63-2.29zM20 13c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm4 3.43c0-.81-.48-1.53-1.22-1.85-.85-.37-1.79-.58-2.78-.58-.39 0-.76.04-1.13.1.4.68.63 1.46.63 2.29V18H24v-1.57zM12 6c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3z"></path>
						</svg>
						<p>People Invested</p>
						<h1>40000+</h1>
					</div>
					<div className="bonds">
						<svg
							stroke="currentColor"
							fill="currentColor"
							stroke-width="0"
							viewBox="0 0 20 20"
							className="bonds-svg"
							height="1em"
							width="1em"
							xmlns="http://www.w3.org/2000/svg"
						>
							<path
								fill-rule="evenodd"
								d="M10 18a8 8 0 100-16 8 8 0 000 16zM7 5a1 1 0 100 2h1a2 2 0 011.732 1H7a1 1 0 100 2h2.732A2 2 0 018 11H7a1 1 0 00-.707 1.707l3 3a1 1 0 001.414-1.414l-1.483-1.484A4.008 4.008 0 0011.874 10H13a1 1 0 100-2h-1.126a3.976 3.976 0 00-.41-1H13a1 1 0 100-2H7z"
								clip-rule="evenodd"
							></path>
						</svg>
						<p>Bonds Subscribed</p>
						<h1>650+ Cr</h1>
					</div>
					<div className="defaults">
						<svg
							stroke="currentColor"
							fill="currentColor"
							stroke-width="0"
							viewBox="0 0 20 20"
							className="defaults-svg"
							height="1em"
							width="1em"
							xmlns="http://www.w3.org/2000/svg"
						>
							<path
								fill-rule="evenodd"
								d="M12 13a1 1 0 100 2h5a1 1 0 001-1V9a1 1 0 10-2 0v2.586l-4.293-4.293a1 1 0 00-1.414 0L8 9.586 3.707 5.293a1 1 0 00-1.414 1.414l5 5a1 1 0 001.414 0L11 9.414 14.586 13H12z"
								clip-rule="evenodd"
							></path>
						</svg>
						<p>People Invested</p>
						<h1>0%</h1>
					</div>
				</div>
			</div>
			<div className="container grid">
				<div className="content">
					<h1>
						You can invest in carefully curated{" "}
						<span className="green">bonds</span>.
					</h1>
					<div className="whybuy">
						<img
							src="https://d1c9xn9tvapvue.cloudfront.net/landing-v2/dollar-coin.svg"
							alt="rupee-img"
						/>
						<div className="whybuycont">
							<h4>Bonds credited to your DEMAT.</h4>
							<p>
								A simple entry to investing in bonds for all
								kinds of investors.
							</p>
						</div>
					</div>
					<div className="whybuy">
						<img
							src="https://d1c9xn9tvapvue.cloudfront.net/landing-v2/dollar-coin.svg"
							alt="rupee-img"
						/>
						<div className="whybuycont">
							<h4>Bonds credited to your DEMAT.</h4>
							<p>
								A simple entry to investing in bonds for all
								kinds of investors.
							</p>
						</div>
					</div>
					<div className="whybuy">
						<img
							src="https://d1c9xn9tvapvue.cloudfront.net/landing-v2/dollar-coin.svg"
							alt="rupee-img"
						/>
						<div className="whybuycont">
							<h4>Bonds credited to your DEMAT.</h4>
							<p>
								A simple entry to investing in bonds for all
								kinds of investors.
							</p>
						</div>
					</div>
				</div>
				<img className="man" src="/second.jpg" alt="man" />
			</div>
			<div className="about container">
				<h1>About us:</h1>
				<p className="about-p">
					Take a look at the team behind petifying India !
				</p>
				<div className="founders">
					<div className="rupam">
						<h3>Sai SS</h3>
						<p>
							Hi I'm Sai SS, co-founder at Bond Chain.
							<br />
							I'm pursuing BTech in CSE at VIT Vellore and I'm a
							proud member of the Bond Chain family.
							<br />
							Lorem, ipsum dolor sit amet consectetur adipisicing
							elit. Fugiat dolorum debitis necessitatibus qui
							tempore illum at unde rem in numquam aut accusantium
							tenetur aperiam repudiandae excepturi quidem
							reprehenderit praesentium, fugit ex repellendus
							pariatur quae quos sit. Doloremque, sunt quo omnis
							nam quas assumenda perferendis libero, eaque
							voluptas optio qui officia.
						</p>
					</div>
					<img
						src="/male.png"
						alt="rupam-dp"
						width="180px"
						height="180px"
					/>
					<div className="arjun">
						<h3>Arjun Khanna</h3>
						<p>
							Hi I'm Arjun Khanna, co-founder at Bond Chain.
							<br />
							I'm pursuing BTech in CSE at VIT Vellore and I'm a
							proud member of the Bond Chain family.
							<br />
							Lorem, ipsum dolor sit amet consectetur adipisicing
							elit. Fugiat dolorum debitis necessitatibus qui
							tempore illum at unde rem in numquam aut accusantium
							tenetur aperiam repudiandae excepturi quidem
							reprehenderit praesentium, fugit ex repellendus
							pariatur quae quos sit. Doloremque, sunt quo omnis
							nam quas assumenda perferendis libero, eaque
							voluptas optio qui officia.
						</p>
					</div>
					<img
						src="/male.png"
						alt="arjun-dp"
						width="180px"
						height="180px"
					/>
					<div className="mohmika">
						<h3>Kashish Jain</h3>
						<p>
							Hi I'm Kashish Jain, co-founder at Bond Chain.
							<br />
							I'm pursuing BTech in CSE at VIT Vellore and I'm a
							proud member of the Bond Chain family.
							<br />
							Lorem, ipsum dolor sit amet consectetur adipisicing
							elit. Fugiat dolorum debitis necessitatibus qui
							tempore illum at unde rem in numquam aut accusantium
							tenetur aperiam repudiandae excepturi quidem
							reprehenderit praesentium, fugit ex repellendus
							pariatur quae quos sit. Doloremque, sunt quo omnis
							nam quas assumenda perferendis libero, eaque
							voluptas optio qui officia.
						</p>
					</div>
					<img
						src="/female.png"
						alt="mohmika-dp"
						width="180px"
						height="180px"
					/>
					<div className="dhananjay">
						<h3>Sriram SS</h3>
						<p>
							Hi I'm Sriram SS, co-founder at Bond Chain.
							<br />
							I'm pursuing BTech in CSE at VIT Vellore and I'm a
							proud member of the Bond Chain family.
							<br />
							Lorem, ipsum dolor sit amet consectetur adipisicing
							elit. Fugiat dolorum debitis necessitatibus qui
							tempore illum at unde rem in numquam aut accusantium
							tenetur aperiam repudiandae excepturi quidem
							reprehenderit praesentium, fugit ex repellendus
							pariatur quae quos sit. Doloremque, sunt quo omnis
							nam quas assumenda perferendis libero, eaque
							voluptas optio qui officia.
						</p>
					</div>
					<img
						src="/male.png"
						alt="dhananjay-dp"
						width="180px"
						height="180px"
					/>
				</div>
			</div>
			<footer>
				<div className="container">
					<div className="branding">
						<a href="#">
							<img
								src="/logo footer.png"
								alt="not found"
								width="75px"
								height="75px"
							/>
						</a>
						<a href="index.html">
							<h1>Bond Chain</h1>
						</a>
					</div>
					<p>© 2022 Bond Chain. All rights reserved</p>
					<div className="socials">
						<a
							href="https://www.instagram.com/vinnovateit/"
							target="_blank"
							rel="noreferrer"
						>
							<img
								className="white-bg"
								src="/instagram.png"
								alt="insta icon"
							/>
						</a>
						<a
							href="https://twitter.com/v_innovate_it"
							target="_blank"
							rel="noreferrer"
						>
							<img
								className="white-bg"
								src="/twitter.png"
								alt="twitter icon"
							/>
						</a>
						<a
							href="https://github.com/arjun-sir/eth-for-all"
							target="_blank"
							rel="noreferrer"
						>
							<img
								className="white-bg"
								src="/github.png"
								alt="github icon"
							/>
						</a>
					</div>
				</div>
			</footer>
		</div>
	);
};
