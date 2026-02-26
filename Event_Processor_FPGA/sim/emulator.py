import matplotlib.pyplot as plt

# --- Simulation Parameters ---
IDLE_LIMIT = 10  # Maximum clock cycles to wait before closing an event
# Input signal simulation: 1 = Pulse detected, 0 = No pulse
# Pattern: Two bursts of pulses with different durations
sensor_signal = [0] * 10 + [1, 0, 0, 1, 0, 0, 0, 1] + [0] * 20 + [1, 0, 1] + [0] * 150
time_steps = range(len(sensor_signal))

# --- Internal States ---
burst_timer = 0
idle_timer = 0
is_active = False

# --- Output Storage ---
wrreq_log = [0] * len(sensor_signal)
data_log = [0] * len(sensor_signal)

# --- Cycle-Accurate Emulation ---
for t in range(len(sensor_signal)):
    if sensor_signal[t] == 1:
        is_active = True
        idle_timer = 0
        burst_timer += 1
    elif is_active:
        idle_timer += 1
        burst_timer += 1

        # Check if the event has ended (Idle limit reached)
        if idle_timer >= IDLE_LIMIT:
            is_active = False
            # Store burst duration (excluding the trailing idle period)
            wrreq_log[t] = 1
            data_log[t] = burst_timer - IDLE_LIMIT
            burst_timer = 0
            idle_timer = 0

# --- Visualization ---
fig, (ax1, ax2, ax3) = plt.subplots(3, 1, figsize=(15, 8), sharex=True)

# Plot 1: Input Sensor Signal
ax1.step(time_steps, sensor_signal, where='post', color='blue')
ax1.set_title("Input Signal (Sensor Strobe)")
ax1.grid(True)

# Plot 2: FIFO Write Request (Trigger)
ax2.step(time_steps, wrreq_log, where='post', color='red')
ax2.set_title("FIFO Write Request (wrreq)")
ax2.grid(True)

# Plot 3: Captured Event Data (Duration)
ax3.stem(time_steps, data_log, linefmt='C0-', markerfmt='C0o', basefmt='r-')
ax3.set_title("FIFO Data (Burst Duration in clock cycles)")
ax3.set_xlabel("Time (clk cycles)")
ax3.grid(True)

plt.tight_layout()
plt.show()