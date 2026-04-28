# Failover Strategy

## Objective
Ensure the system continues to operate even if:
- A service fails
- An AZ goes down
- An entire region becomes unavailable

---

## Failure Levels

### 1. Instance / Container Failure
Handled by ECS:
- Failed containers are automatically replaced
- Health checks ensure unhealthy tasks are removed

---

### 2. AZ Failure
Handled by Multi-AZ setup:
- ALB routes traffic to healthy AZs
- RDS Multi-AZ failover is automatic

---

### 3. Regional Failure

This is the critical scenario.

#### Detection
- Route53 health checks monitor endpoints

#### Response
- Traffic automatically routed to healthy region
- No manual intervention required

---

## Data Considerations

- Cross-region replication ensures data availability
- Some replication lag is expected (seconds)
- System is designed to tolerate this

---

## Stateless Recovery

Because services are stateless:
- No dependency on local state
- New instances can spin up instantly in another region

---

## Deployment Safety

- Rolling deployments avoid full outages
- Blue/Green (future improvement) for safer releases

---

## Observability During Failures

- CloudWatch alarms trigger alerts
- Logs centralized for debugging
- Metrics monitored in real-time

---

## Known Limitations

- DNS failover is not instant (few seconds delay)
- In-flight requests during failure may be lost
- Data replication lag can affect edge cases

---

## Final Note

The system is designed not to **avoid failure**, but to **handle it gracefully and recover quickly**.