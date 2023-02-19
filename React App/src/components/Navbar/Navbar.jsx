import React from "react";
import "../../App.css";
import { Link, Outlet } from "react-router-dom";
import "../Navbar/Navbar.css";

export const Navbar = () => {
	return (
		<>
			<div className="header">
				<div className="container">
					<div className="branding">
						<a href="index.html">
							<img
								src="/logo.png"
								alt="not found"
								width="75px"
								height="75px"
							/>
						</a>
						<Link to="/">
							<a>
								<h1>Bond Chain</h1>
							</a>
						</Link>
					</div>
					<nav>
						<ul>
							<li>
								<a href="#">INVEST</a>
							</li>
							<li>
								<a href="#">LEARN</a>
							</li>
							<li>
								<a href="#">ETC</a>
							</li>
							<li>
								<a href="#">FAQS</a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
			<Outlet />
		</>
	);
};
