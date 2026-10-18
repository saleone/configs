import { execFileSync } from "node:child_process";
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";
import { lookup } from "@oh-my-pi/pi-coding-agent/config/registry";

// Key Mnemopi memory on the git `origin` remote, so every clone or worktree of
// one repository shares a bank regardless of where it is checked out.
// Outside a git repo (or without `origin`) the configured scoping applies.
function remoteBank(cwd: string): string | undefined {
	let url: string;
	try {
		url = execFileSync("git", ["-C", cwd, "remote", "get-url", "origin"], {
			encoding: "utf8",
			stdio: ["ignore", "pipe", "ignore"],
		}).trim();
	} catch {
		return undefined;
	}
	// git@host:owner/repo.git | ssh://git@host:22/owner/repo | https://user@host/owner/repo.git
	const normalized = url
		.replace(/^[a-z+]+:\/\//i, "")
		.replace(/^[^@/]+@/, "")
		.replace(/:(\d+\/)?/, "/")
		.replace(/\.git\/?$/, "")
		.replace(/\/+$/, "")
		.toLowerCase();
	return normalized.replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "") || undefined;
}

export default function (pi: ExtensionAPI) {
	const bank = remoteBank(process.cwd());
	if (!bank) return;
	lookup("mnemopi.scoping")?.override(pi.pi.settings, "global");
	lookup("mnemopi.bank")?.override(pi.pi.settings, bank);
}
