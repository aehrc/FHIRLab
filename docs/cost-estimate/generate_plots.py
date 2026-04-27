#!/usr/bin/env python3
"""Generate cost comparison plots for FHIRLab Core APAC cloud deployment."""

import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np
import os

OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))

# --- Data ---

providers = [
    "Oracle Free\n(ARM)",
    "Hetzner ARM\n(SG)",
    "Oracle Paid\n(ARM)",
    "Hetzner AMD\n(SG)",
    "Vultr",
    "Linode",
    "DigitalOcean",
]

monthly_compute = [0, 8, 10, 17, 48, 48, 48]
monthly_storage = [0, 0, 1.25, 0, 0, 0, 0]  # included or negligible
monthly_total = [c + s for c, s in zip(monthly_compute, monthly_storage)]
annual_total = [m * 12 for m in monthly_total]

ram_gb = [24, 8, 8, 8, 8, 8, 8]
storage_gb = [200, 80, 100, 160, 160, 160, 160]
bandwidth_tb = [10, 20, 10, 20, 5, 5, 5]

apac_regions = {
    "Oracle Free\n(ARM)": ["SG", "TYO", "SYD", "MUM", "OSA", "SEL", "HYD", "MEL"],
    "Hetzner ARM\n(SG)": ["SG"],
    "Oracle Paid\n(ARM)": ["SG", "TYO", "SYD", "MUM", "OSA", "SEL", "HYD", "MEL"],
    "Hetzner AMD\n(SG)": ["SG"],
    "Vultr": ["SG", "TYO", "SYD", "MUM"],
    "Linode": ["SG", "TYO", "SYD", "MUM"],
    "DigitalOcean": ["SG", "SYD", "BLR"],
}

colors = ["#2ecc71", "#3498db", "#1abc9c", "#2980b9", "#e74c3c", "#e67e22", "#9b59b6"]


# --- Plot 1: Monthly cost comparison ---

fig, ax = plt.subplots(figsize=(10, 5))
bars = ax.barh(providers, monthly_total, color=colors, edgecolor="white", height=0.6)
for bar, cost in zip(bars, monthly_total):
    label = "FREE" if cost == 0 else f"${cost:.0f}"
    ax.text(bar.get_width() + 1, bar.get_y() + bar.get_height() / 2, label,
            va="center", fontweight="bold", fontsize=11)
ax.set_xlabel("Monthly Cost (USD)", fontsize=12)
ax.set_title("FHIRLab Core — Monthly Hosting Cost by Provider (4 vCPU / 8GB+ RAM)", fontsize=13)
ax.set_xlim(0, 60)
ax.xaxis.set_major_formatter(ticker.FormatStrFormatter("$%d"))
ax.invert_yaxis()
plt.tight_layout()
plt.savefig(os.path.join(OUTPUT_DIR, "monthly_cost_comparison.png"), dpi=150)
plt.close()


# --- Plot 2: Annual cost projection (3 years) ---

years = [1, 2, 3]
fig, ax = plt.subplots(figsize=(10, 5))
for i, provider in enumerate(providers):
    costs = [monthly_total[i] * 12 * y for y in years]
    marker = "o" if monthly_total[i] > 0 else "D"
    ax.plot(years, costs, marker=marker, linewidth=2, label=provider, color=colors[i])
    ax.annotate(f"${costs[-1]:,.0f}", (years[-1], costs[-1]),
                textcoords="offset points", xytext=(8, 0), fontsize=9)

ax.set_xlabel("Year", fontsize=12)
ax.set_ylabel("Cumulative Cost (USD)", fontsize=12)
ax.set_title("FHIRLab Core — Cumulative Hosting Cost Over 3 Years", fontsize=13)
ax.set_xticks(years)
ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, _: f"${x:,.0f}"))
ax.legend(loc="upper left", fontsize=8)
ax.grid(axis="y", alpha=0.3)
plt.tight_layout()
plt.savefig(os.path.join(OUTPUT_DIR, "annual_cost_projection.png"), dpi=150)
plt.close()


# --- Plot 3: Value comparison (RAM per dollar) ---

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))

ax1.barh(providers, ram_gb, color=colors, edgecolor="white", height=0.6)
for bar, val in zip(ax1.patches, ram_gb):
    ax1.text(bar.get_width() + 0.3, bar.get_y() + bar.get_height() / 2,
             f"{val} GB", va="center", fontsize=10)
ax1.set_xlabel("RAM (GB)", fontsize=11)
ax1.set_title("Available RAM", fontsize=12)
ax1.invert_yaxis()
ax1.set_xlim(0, 30)

ax2.barh(providers, bandwidth_tb, color=colors, edgecolor="white", height=0.6)
for bar, val in zip(ax2.patches, bandwidth_tb):
    ax2.text(bar.get_width() + 0.3, bar.get_y() + bar.get_height() / 2,
             f"{val} TB", va="center", fontsize=10)
ax2.set_xlabel("Bandwidth (TB/month)", fontsize=11)
ax2.set_title("Included Bandwidth", fontsize=12)
ax2.invert_yaxis()
ax2.set_xlim(0, 25)

fig.suptitle("FHIRLab Core — Resource Comparison by Provider", fontsize=13)
plt.tight_layout()
plt.savefig(os.path.join(OUTPUT_DIR, "resource_comparison.png"), dpi=150)
plt.close()

print("Plots generated:")
print(f"  {OUTPUT_DIR}/monthly_cost_comparison.png")
print(f"  {OUTPUT_DIR}/annual_cost_projection.png")
print(f"  {OUTPUT_DIR}/resource_comparison.png")
