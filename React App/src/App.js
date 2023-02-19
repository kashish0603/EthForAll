import "./App.css";
import { Landing } from "./components/Landing/Landing.jsx";
import { Navbar } from "./components/Navbar/Navbar.jsx";
import { Dashboard } from "./components/Dashboard/Dashboard.jsx";
import { Routes, Route } from "react-router-dom";

function App() {
	return (
		<div className="App">
			<Routes>
				<Route path="/" element={<Navbar />}>
					<Route index element={<Landing />} />
					<Route path="dashboard" element={<Dashboard />} />
				</Route>
			</Routes>
		</div>
	);
}

export default App;
