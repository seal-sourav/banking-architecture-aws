# ADR-002: Global Traffic Routing Strategy

## Status
Accepted

## Context
The platform serves users across multiple geographies. Key requirements:
- Low latency user experience
- Automatic failover during regional outages
- Even traffic distribution under normal conditions

Routing strategy is critical for:
- Performance
- Availability
- User experience

## Decision
Use **Amazon Route53 Latency-Based Routing with Health Checks**.

## Architecture Approach
- Route53 directs users to the lowest-latency region
- Health checks continuously monitor regional endpoints
- If a region becomes unhealthy, traffic is automatically rerouted

## Why Latency-Based Routing?

### ✅ Benefits
- Optimizes user experience globally
- Reduces response time
- Automatically adapts to network conditions

## Failover Mechanism
- Health checks detect failure
- Route53 removes unhealthy endpoints
- Traffic shifts to healthy region within seconds

## Alternatives Considered

### 1. Weighted Routing
- Not optimal for latency-sensitive applications

### 2. Geo Routing
- Static and less adaptive to real-time latency

### 3. Anycast (CloudFront only)
- Not sufficient for full application routing

## Trade-offs

### ❌ Limitations
- Slight DNS propagation delay
- Requires proper health check tuning

## Notes
Combined with **CloudFront**, this provides:
- Edge optimization
- DDoS protection layer
- Reduced backend load