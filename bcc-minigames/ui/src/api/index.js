import axios from "axios";

const api = axios.create({
	baseURL: `https://${typeof GetParentResourceName !== 'undefined' ? GetParentResourceName() : 'bcc-minigames'}/`,
});

export default api;
